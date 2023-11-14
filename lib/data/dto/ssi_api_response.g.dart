// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ssi_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SsiApiResponse _$SsiApiResponseFromJson(Map<String, dynamic> json) =>
    SsiApiResponse(
      json['code'] as String,
      json['message'] as String,
      json['data'],
    );

Map<String, dynamic> _$SsiApiResponseToJson(SsiApiResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
