import 'package:json_annotation/json_annotation.dart';

part 'ssi_api_response.g.dart';

@JsonSerializable()
class SsiApiResponse {
  final String code;
  final String message;
  final dynamic data;

  SsiApiResponse(this.code, this.message, this.data);

  factory SsiApiResponse.fromJson(Map<String, dynamic> json) =>
      _$SsiApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SsiApiResponseToJson(this);

  @override
  String toString() {
    return 'SsiApiResponse{code: $code, message: $message, data: $data}';
  }
}
