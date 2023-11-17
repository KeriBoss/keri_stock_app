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
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    PhoneVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<PhoneVerificationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PhoneVerificationScreen(
          key: args.key,
          user: args.user,
          purpose: args.purpose,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterScreen(
          key: args.key,
          isShipper: args.isShipper,
        ),
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
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PhoneVerificationScreen]
class PhoneVerificationRoute extends PageRouteInfo<PhoneVerificationRouteArgs> {
  PhoneVerificationRoute({
    Key? key,
    required User user,
    required PhoneVerifyPurposeEnum purpose,
    List<PageRouteInfo>? children,
  }) : super(
          PhoneVerificationRoute.name,
          args: PhoneVerificationRouteArgs(
            key: key,
            user: user,
            purpose: purpose,
          ),
          initialChildren: children,
        );

  static const String name = 'PhoneVerificationRoute';

  static const PageInfo<PhoneVerificationRouteArgs> page =
      PageInfo<PhoneVerificationRouteArgs>(name);
}

class PhoneVerificationRouteArgs {
  const PhoneVerificationRouteArgs({
    this.key,
    required this.user,
    required this.purpose,
  });

  final Key? key;

  final User user;

  final PhoneVerifyPurposeEnum purpose;

  @override
  String toString() {
    return 'PhoneVerificationRouteArgs{key: $key, user: $user, purpose: $purpose}';
  }
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    required bool isShipper,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(
            key: key,
            isShipper: isShipper,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<RegisterRouteArgs> page =
      PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    required this.isShipper,
  });

  final Key? key;

  final bool isShipper;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, isShipper: $isShipper}';
  }
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
