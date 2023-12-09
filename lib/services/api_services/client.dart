import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class BaseApiClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final Logger logger; // You need to pass a logger instance to the constructor.

  BaseApiClient(
    this.baseUrl,
    this.logger, {
    this.defaultHeaders = const {},
  });

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$path');
    final allHeaders = {...defaultHeaders, ...?headers};

    logger.i('HTTP GET Request to: $uri');
    logger.i('Headers: $allHeaders');

    final response = await http.get(uri, headers: allHeaders);

    logger.i('HTTP Response:');
    logger.i('Status Code: ${response.statusCode}');
    logger.i('Response Body: ${response.body}');

    return response;
  }

  Future<http.Response> post(
    String path,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final allHeaders = {...defaultHeaders, ...?headers};

    logger.i('HTTP POST Request to: $uri');
    logger.i('Headers: $allHeaders');
    logger.i('Request Body: $body');

    final response = await http.post(uri, headers: allHeaders, body: body);

    logger.i('HTTP Response:');
    logger.i('Status Code: ${response.statusCode}');
    logger.i('Response Body: ${response.body}');

    return response;
  }

  Future<http.Response> put(
    String path,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    final allHeaders = {...defaultHeaders, ...?headers};

    logger.i('HTTP PUT Request to: $uri');
    logger.i('Headers: $allHeaders');
    logger.i('Request Body: $body');

    final response = await http.put(uri, headers: allHeaders, body: body);

    logger.i('HTTP Response:');
    logger.i('Status Code: ${response.statusCode}');
    logger.i('Response Body: ${response.body}');

    return response;
  }

  Future<http.Response> delete(String path,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$path');
    final allHeaders = {...defaultHeaders, ...?headers};

    logger.i('HTTP DELETE Request to: $uri');
    logger.i('Headers: $allHeaders');

    final response = await http.delete(uri, headers: allHeaders);

    logger.i('HTTP Response:');
    logger.i('Status Code: ${response.statusCode}');
    logger.i('Response Body: ${response.body}');

    return response;
  }

  // Add more methods for other HTTP methods like PATCH, HEAD, etc.
}
