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
    AboutAppRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutAppPage(),
      );
    },
    ArenaDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ArenaDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ArenaDetailsPage(
          key: args.key,
          arena: args.arena,
        ),
      );
    },
    BookingFormRoute.name: (routeData) {
      final args = routeData.argsAs<BookingFormRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookingFormPage(
          key: args.key,
          arena: args.arena,
        ),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangePasswordPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditProfilePage(
          key: args.key,
          user: args.user,
        ),
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
/// [AboutAppPage]
class AboutAppRoute extends PageRouteInfo<void> {
  const AboutAppRoute({List<PageRouteInfo>? children})
      : super(
          AboutAppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutAppRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ArenaDetailsPage]
class ArenaDetailsRoute extends PageRouteInfo<ArenaDetailsRouteArgs> {
  ArenaDetailsRoute({
    Key? key,
    required Arena arena,
    List<PageRouteInfo>? children,
  }) : super(
          ArenaDetailsRoute.name,
          args: ArenaDetailsRouteArgs(
            key: key,
            arena: arena,
          ),
          initialChildren: children,
        );

  static const String name = 'ArenaDetailsRoute';

  static const PageInfo<ArenaDetailsRouteArgs> page =
      PageInfo<ArenaDetailsRouteArgs>(name);
}

class ArenaDetailsRouteArgs {
  const ArenaDetailsRouteArgs({
    this.key,
    required this.arena,
  });

  final Key? key;

  final Arena arena;

  @override
  String toString() {
    return 'ArenaDetailsRouteArgs{key: $key, arena: $arena}';
  }
}

/// generated route for
/// [BookingFormPage]
class BookingFormRoute extends PageRouteInfo<BookingFormRouteArgs> {
  BookingFormRoute({
    Key? key,
    required Arena arena,
    List<PageRouteInfo>? children,
  }) : super(
          BookingFormRoute.name,
          args: BookingFormRouteArgs(
            key: key,
            arena: arena,
          ),
          initialChildren: children,
        );

  static const String name = 'BookingFormRoute';

  static const PageInfo<BookingFormRouteArgs> page =
      PageInfo<BookingFormRouteArgs>(name);
}

class BookingFormRouteArgs {
  const BookingFormRouteArgs({
    this.key,
    required this.arena,
  });

  final Key? key;

  final Arena arena;

  @override
  String toString() {
    return 'BookingFormRouteArgs{key: $key, arena: $arena}';
  }
}

/// generated route for
/// [ChangePasswordPage]
class ChangePasswordRoute extends PageRouteInfo<void> {
  const ChangePasswordRoute({List<PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    Key? key,
    required User user,
    List<PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<EditProfileRouteArgs> page =
      PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, user: $user}';
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
