// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ArenaDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ArenaDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ArenaDetailsPage(arena: args.arena),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MainDashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainDashboardPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [ArenaDetailsPage]
class ArenaDetailsRoute extends PageRouteInfo<ArenaDetailsRouteArgs> {
  ArenaDetailsRoute({
    required Arena arena,
    List<PageRouteInfo>? children,
  }) : super(
          ArenaDetailsRoute.name,
          args: ArenaDetailsRouteArgs(arena: arena),
          initialChildren: children,
        );

  static const String name = 'ArenaDetailsRoute';

  static const PageInfo<ArenaDetailsRouteArgs> page =
      PageInfo<ArenaDetailsRouteArgs>(name);
}

class ArenaDetailsRouteArgs {
  const ArenaDetailsRouteArgs({required this.arena});

  final Arena arena;

  @override
  String toString() {
    return 'ArenaDetailsRouteArgs{arena: $arena}';
  }
}

/// generated route for
/// [LoginPage]
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
/// [MainDashboardPage]
class MainDashboardRoute extends PageRouteInfo<void> {
  const MainDashboardRoute({List<PageRouteInfo>? children})
      : super(
          MainDashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainDashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
