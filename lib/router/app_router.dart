// The part directive must be after imports
import 'package:auto_route/auto_route.dart';
import '../features/dashboard/domain/entities/arena.dart';
import '../features/dashboard/presentation/pages/arena_details_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/dashboard/presentation/pages/main_dashboard_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: MainDashboardRoute.page),
        AutoRoute(page: ArenaDetailsRoute.page),
      ];
}
