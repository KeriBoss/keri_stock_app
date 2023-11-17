import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stock_market_project/data/entities/stock.dart';

import '../../data/repositories/stock_crawler_repository.dart';

part 'stock_crawler_event.dart';
part 'stock_crawler_state.dart';

class StockCrawlerBloc extends Bloc<StockCrawlerEvent, StockCrawlerState> {
  final StockCrawlerRepository _stockCrawlerRepository;

  List<Stock> stockList = [];
  String currentGroupSymbol = '';

  StockCrawlerBloc(this._stockCrawlerRepository)
      : super(StockCrawlerInitial()) {
    on<OnLoadStockListFromGroupSymbolEvent>((event, emit) async {
      try {
        final res = await _stockCrawlerRepository.getStockListByGroupSymbol(
          event.groupSymbol,
        );

        res.fold(
          (failure) => emit(StockCrawlerErrorState(failure.message)),
          (list) {
            stockList = List.of(list);
            currentGroupSymbol = event.groupSymbol;

            emit(StockListFromGroupSymbolLoadedState(
              stockList,
              currentGroupSymbol,
            ));
          },
        );
      } catch (e, stackTrace) {
        debugPrint('Caught error: ${e.toString()} \n${stackTrace.toString()}');
        emit(StockCrawlerErrorState(e.toString()));
      }
    });
  }
}
