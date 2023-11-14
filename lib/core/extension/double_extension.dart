import 'package:flutter/cupertino.dart';
import 'package:stock_market_project/core/extension/number_extension.dart';

extension SpaceWidget on double {
  Widget get horizontalSpace => SizedBox(height: width.width);
  Widget get verticalSpace => SizedBox(height: height.height);
}
