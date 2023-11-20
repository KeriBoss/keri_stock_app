import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_project/core/failure/failure.dart';
import 'package:stock_market_project/main.dart';

class NetworkService {
  static const String domain = 'http://34.67.65.197:8080/api_chungkhoan/api';

  static Map<String, String> headers = {'Content-Type': 'application/json'};

  static Future<Either<Failure, dynamic>> post({
    required Map<String, dynamic> paramBody,
    required String url,
  }) async {
    try {
      var formData = FormData.fromMap(paramBody);

      final response = await dio.post(
        domain + url,
        data: formData,
      );

      debugPrint(formData.toString());

      if (response.data.toString() == '[]') {
        return Left(
          ApiFailure(response.statusMessage ?? 'Error POST $domain$url'),
        );
      } else {
        return Right(response.data);
      }
    } catch (e, stackTrace) {
      debugPrint(
        'Caught POST $domain$url error: ${e.toString()} \n${stackTrace.toString()}',
      );

      return Left(ApiFailure(e.toString()));
    }
  }

  static Future<Either<Failure, dynamic>> get({
    Map<String, dynamic>? queryParam,
    required String url,
  }) async {
    try {
      final response = await dio.get(
        domain + url,
        queryParameters: queryParam,
      );

      if (response.data.toString() == '[]') {
        return Left(
          ApiFailure(response.statusMessage ?? 'Error GET $domain$url'),
        );
      } else {
        return Right(response.data);
      }
    } catch (e, stackTrace) {
      debugPrint(
        'Caught GET $domain$url error: ${e.toString()} \n${stackTrace.toString()}',
      );

      return Left(ApiFailure(e.toString()));
    }
  }
}
