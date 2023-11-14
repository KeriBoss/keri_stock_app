// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router_config.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ClientIndexRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ClientIndexScreen(),
      );
    },
    StockRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StockScreen(),
      );
    },
  };
}

/// generated route for
/// [ClientIndexScreen]
class ClientIndexRoute extends PageRouteInfo<void> {
  const ClientIndexRoute({List<PageRouteInfo>? children})
      : super(
          ClientIndexRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClientIndexRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StockScreen]
class StockRoute extends PageRouteInfo<void> {
  const StockRoute({List<PageRouteInfo>? children})
      : super(
          StockRoute.name,
          initialChildren: children,
        );

  static const String name = 'StockRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
