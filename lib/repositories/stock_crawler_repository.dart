import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_project/core/failure/failure.dart';
import 'package:stock_market_project/data/dto/ssi_api_response.dart';
import 'package:stock_market_project/data/entities/stock.dart';
import 'package:stock_market_project/main.dart';

class StockCrawlerRepository {
  Future<Either<Failure, List<Stock>>> getStockListByGroupSymbol(
    String groupSymbol,
  ) async {
    try {
      SsiApiResponse? apiRes;

      final response = await dio
          .get('https://iboard-query.ssi.com.vn/stock/group/$groupSymbol');

      apiRes = SsiApiResponse.fromJson(response.data);

      print(apiRes.data);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = apiRes.data;

        return Right(jsonList.map((json) => Stock.fromJson(json)).toList());
      } else {
        return Left(ApiFailure(apiRes.message));
      }
    } catch (e, stackTrace) {
      debugPrint(
        'Caught get stock list from a group error: ${e.toString()} \n${stackTrace.toString()}',
      );
      return Left(ExceptionFailure(e.toString()));
    }
  }
}
