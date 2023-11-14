import 'package:auto_route/auto_route.dart';

import '../../views/screens/client_index_screen.dart';
import '../../views/screens/stock_screen.dart';
import 'app_router_path.dart';

part 'app_router_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: StockRoute.page,
          path: AppRouterPath.stock,
          initial: true,
        ),
        AutoRoute(
          page: ClientIndexRoute.page,
          path: AppRouterPath.clientIndex,
        ),
      ];
}
