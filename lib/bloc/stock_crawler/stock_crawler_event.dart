part of 'stock_crawler_bloc.dart';

abstract class StockCrawlerEvent extends Equatable {
  const StockCrawlerEvent();

  @override
  List<Object?> get props => [];
}

class OnLoadStockListFromGroupSymbolEvent extends StockCrawlerEvent {
  final String groupSymbol;

  const OnLoadStockListFromGroupSymbolEvent(this.groupSymbol);
}
