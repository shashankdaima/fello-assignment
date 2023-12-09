/* Your View Model (VM) code here */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/repository/news_article_caching_strategy.dart';
import 'package:flutter_template/services/api_services/dto/news_api_paginate_models/success_response.dart';
import 'package:flutter_template/services/api_services/news_api_client.dart';
import 'package:flutter_template/util/resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_template/services/api_services/dto/news_api_paginate_models/error_response.dart'
    as news_api_error_models;
import 'package:flutter_template/services/api_services/dto/news_api_paginate_models/success_response.dart'
    as news_api_success_models;
import 'package:logger/logger.dart';

import '../../util/logger.dart';

part 'api_paging_screen_vm.freezed.dart';

final apiPagingScreenVmProvider = StateNotifierProvider.autoDispose<
        ApiPagingScreenVm, ApiPagingScreenVmState>(
    ((ref) => ApiPagingScreenVm(
        ref: ref,
        logger: ref.read(loggerProvider),
        newsArticleCachingStrategy:
            ref.read(newsArticleCachingStrategyProvider))));

class ApiPagingScreenVm extends StateNotifier<ApiPagingScreenVmState> {
  final StateNotifierProviderRef ref;
  final Logger logger;
  final NewsArticleCachingStrategy newsArticleCachingStrategy;

  ApiPagingScreenVm(
      {required this.ref,
      required this.logger,
      required this.newsArticleCachingStrategy})
      : super(const ApiPagingScreenVmState()) {
    readFromCachingStrategy();
  }

  // void howToUsePaginatedApiWithStateManagement() async {
  //   state = state.copyWith(status: ApiPagingScreenVmStatus.loading);
  //   try {
  //     // Code that may throw an exception
  //     // Usually whole async functionality should go here.
  //     // await Future.delayed(const Duration(seconds: 2));
  //     final response =
  //         await newsApiClient.getPaginatedNewsAboutTopic("bitcoin", 1, 1);
  //     switch (response.runtimeType) {
  //       case news_api_success_models.SuccessResponse:
  //         state = state.copyWith(status: ApiPagingScreenVmStatus.loaded);
  //         break;
  //       case news_api_error_models.ErrorResponse:
  //         logger.e((response as news_api_error_models.ErrorResponse).message);
  //         state = state.copyWith(
  //             status: ApiPagingScreenVmStatus.error,
  //             errorMessage: (response).message);
  //       default:
  //         state = state.copyWith(
  //             status: ApiPagingScreenVmStatus.error,
  //             errorMessage: "Unknown Exception");
  //     }
  //   } on Error catch (e) {
  //     // Code to handle other exceptions
  //     state = state.copyWith(
  //         status: ApiPagingScreenVmStatus.error, errorMessage: e.toString());
  //   } finally {
  //     state = state.copyWith(status: ApiPagingScreenVmStatus.initial);
  //     // state = state.copyWith(status: FirstScreenVmStatus.loaded);
  //     // if you want to ignore some part of try catch error. Then make
  //     // this either loaded, or initial.
  //   }
  // }
  void readFromCachingStrategy() {
    newsArticleCachingStrategy.invoke(1).listen((event) {
      switch (event.status) {
        case ResourceStatus.loading:
          {
            logger.d("Loading Api");
            break;
          }

        case ResourceStatus.success:
          {
            logger.d(event.data?.length ?? 0);
            state = state.copyWith(
                status: ApiPagingScreenVmStatus.initial,
                newsArticles: [...state.newsArticles, ...event.data ?? []]);
          }
        case ResourceStatus.error:
          {
            logger.d(event.message.toString());
          }
      }
    });
  }
}

@freezed
class ApiPagingScreenVmState with _$ApiPagingScreenVmState {
  const factory ApiPagingScreenVmState({
    @Default(ApiPagingScreenVmStatus.initial) ApiPagingScreenVmStatus status,
    @Default([]) List<NewsArticle> newsArticles,
    String? errorMessage,
  }) = _ApiPagingScreenVmState;
}

enum ApiPagingScreenVmStatus { initial, loading, paginating, error, loaded }
