import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/services/api_services/dto/news_api_paginate_models/error_response.dart';
import 'package:flutter_template/services/api_services/dto/news_api_paginate_models/success_response.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dto/response.dart';
import 'client.dart';

final newsApiClientProvider =
    Provider((ref) => NewsApiClient(logger: ref.read(loggerProvider)));

class NewsApiClient {
  // [CODE SMELL]: API KEY shouldn't be hardcoded.
  static const String _API_KEY = "1308203c56044cbc8eb0e30643c8921c";
  late final Logger logger;
  late final BaseApiClient _client;
  NewsApiClient({required this.logger}) {
    _client =
        BaseApiClient("https://newsapi.org/v2", logger, defaultHeaders: {});
  }

  Future<HttpResponse> getPaginatedNewsAboutTopic(
      String topic, int page, int pageSize) async {
    var response = await _client.get(
        "/everything?q=$topic&apiKey=$_API_KEY&page=$page&pageSize=$pageSize");
    try {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      SuccessResponse successResponse =
          SuccessResponse.fromJson(decodedResponse);
      return successResponse;
    } on TypeError catch (e) {
      // ignore: prefer_interpolation_to_compose_strings
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return ErrorResponse.fromJson(decodedResponse);
    } catch (e) {
      return ErrorResponse(e.toString(), "", "");
    }
  }
}
