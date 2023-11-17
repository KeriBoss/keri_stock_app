import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../data/entities/user.dart';
import '../../data/static/enum/phone_verify_purpose_enum.dart';
import '../../views/screens/client_index_screen.dart';
import '../../views/screens/login_screen.dart';
import '../../views/screens/phone_verification_screen.dart';
import '../../views/screens/register_screen.dart';
import '../../views/screens/stock_screen.dart';
import 'app_router_path.dart';

part 'app_router_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: AppRouterPath.login,
          initial: true,
        ),
        AutoRoute(
          page: StockRoute.page,
          path: AppRouterPath.stock,
        ),
        AutoRoute(
          page: PhoneVerificationRoute.page,
          path: AppRouterPath.phoneVerify,
        ),
        AutoRoute(
          page: ClientIndexRoute.page,
          path: AppRouterPath.clientIndex,
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: AppRouterPath.register,
        ),
      ];
}
