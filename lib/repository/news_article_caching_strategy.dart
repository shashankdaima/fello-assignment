import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/services/api_services/news_api_client.dart';
import 'package:flutter_template/services/db_services/app_db.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:flutter_template/util/resource.dart';
import 'package:logger/logger.dart';

import '../services/api_services/dto/news_api_paginate_models/error_response.dart';
import '../services/api_services/dto/news_api_paginate_models/success_response.dart';

final newsArticleCachingStrategyProvider = Provider((ref) =>
    NewsArticleCachingStrategy(
        logger: ref.read(loggerProvider),
        apiClient: ref.read(newsApiClientProvider),
        appDatabase: ref.read(appDbProvider)));

class NewsArticleCachingStrategy {
  final Logger logger;
  final NewsApiClient apiClient;
  late final Future<AppDatabase> appDatabase;

  NewsArticleCachingStrategy(
      {required this.logger,
      required this.apiClient,
      required this.appDatabase});

  Stream<Resource<List<NewsArticle>>> invokeWithFlow(Stream<int> pages) async* {
    await for (final page in pages) {
      yield Resource.loading(); // Emit a initial loading state.
      // TODO: Check for previous data from database and set cached_data if the cached_data is not expired
      List<NewsArticle> responseFromCache = [];
      yield Resource.loading(data: responseFromCache);
      try {
        // TODO: Perform some asynchronous operation i.e. API Call
        await Future.delayed(const Duration(seconds: 3));
        List<NewsArticle> responseFromApi = [];
        // TODO: saved this data to db,

        // TODO: Get New Cached Data from DB
        List<NewsArticle> newResponseFromCache = [];

        yield Resource.success(newResponseFromCache); // Emit a success state.
      } catch (e) {
        // An error occurred
        yield Resource.error("An error occurred: $e"); // Emit an error state.
      }
    }
  }

  Stream<Resource<List<NewsArticle>>> invoke(int page) async* {
    yield Resource.loading(); // Emit a loading state.
    try {
      try {
        final response =
            await apiClient.getPaginatedNewsAboutTopic("bitcoin", page, 20);
        switch (response.runtimeType) {
          case SuccessResponse:
            // Operation completed successfully
            yield Resource.success((response as SuccessResponse)
                .articles); // Emit a success state.
            break;
          case ErrorResponse:
            final errorMessage = (response as ErrorResponse).message;
            logger.e(errorMessage);
            yield Resource.error(errorMessage);
        }
      } on Error catch (e) {
        // Unwanted Network Errors
        final errorMessage = (e).toString();
        logger.e(errorMessage);
        yield Resource.error(errorMessage);
      }
    } catch (e) {
      // Unknown Errors MP
      // An error occurred
      final errorMessage = (e).toString();
      logger.e(errorMessage);
      yield Resource.error(errorMessage);
    }
  }
}

Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}
