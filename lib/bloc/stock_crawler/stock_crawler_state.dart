part of 'stock_crawler_bloc.dart';

abstract class StockCrawlerState extends Equatable {
  const StockCrawlerState();
}

class StockCrawlerInitial extends StockCrawlerState {
  @override
  List<Object> get props => [];
}

class StockCrawlerLoadingState extends StockCrawlerState {
  @override
  List<Object?> get props => [];
}

class StockListFromGroupSymbolLoadedState extends StockCrawlerState {
  final List<Stock> stockList;
  final String groupSymbol;

  const StockListFromGroupSymbolLoadedState(this.stockList, this.groupSymbol);

  @override
  List<Object?> get props => [stockList, groupSymbol];
}

class StockCrawlerErrorState extends StockCrawlerState {
  final String message;

  const StockCrawlerErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
