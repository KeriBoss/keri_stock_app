import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_project/core/extension/number_extension.dart';
import 'package:stock_market_project/data/entities/stock.dart';

import '../../bloc/stock_crawler/stock_crawler_bloc.dart';

@RoutePage()
class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    context
        .read<StockCrawlerBloc>()
        .add(OnLoadStockListFromGroupSymbolEvent('VNHEAL'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<StockCrawlerBloc, StockCrawlerState>(
          listener: (context, state) {
            if (state is StockListFromGroupSymbolLoadedState) {
              print(state.groupSymbol);
            }
          },
          builder: (context, state) {
            List<Stock> stockList = context.read<StockCrawlerBloc>().stockList;

            if (state is StockListFromGroupSymbolLoadedState) {
              stockList = state.stockList;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: DataTable(
                    columns: [
                      _dataColumn('Mã'),
                      _dataColumn('Trần'),
                      _dataColumn('Sàn'),
                      _dataColumn('TC'),
                      _dataColumn('Giá bán 3'),
                      _dataColumn('Giá bán 2'),
                      _dataColumn('Giá bán 1'),
                      _dataColumn('Giá mua 3'),
                      _dataColumn('Giá mua 2'),
                      _dataColumn('Giá mua 1'),
                    ],
                    rows: List.generate(
                      stockList.length,
                      (index) => _dataRow(stockList[index]),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  DataColumn _dataColumn(String name) {
    return DataColumn(
      label: Expanded(
        child: Text(
          name,
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 5,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 15.size,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  DataRow _dataRow(Stock stock) {
    return DataRow(
      onLongPress: () {},
      cells: [
        DataCell(
          Text(
            stock.stockSymbol ?? ' ',
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.ceiling!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.floor!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.refPrice!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.best3Bid!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.best2Bid!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.best1Bid!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.best3Offer!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.best2Offer!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
        DataCell(
          Text(
            stock.best1Offer!.format,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
