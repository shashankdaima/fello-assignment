import 'package:flutter_template/services/api_services/dto/response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse extends HttpResponse {
  final String message;
  final String code;
  final String status;
  ErrorResponse(this.message, this.code, this.status);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
