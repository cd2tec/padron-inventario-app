import 'package:auto_route/auto_route.dart';
import 'package:padron_inventario_app/routes/guard/permission_guard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.gr.dart';
import 'guard/auth_guard.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard()]),

    // Users
    AutoRoute(page: UserDetailsRoute.page,  guards: [AuthGuard(), PermissionGuard()]),
    AutoRoute(page: UserListRoute.page,     guards: [AuthGuard(), PermissionGuard()]),
    AutoRoute(page: RegisterRoute.page,     guards: [AuthGuard(), PermissionGuard()]),

    // Inventory
    AutoRoute(page: InventoryDetailRoute.page,  guards: [AuthGuard()]),
    AutoRoute(page: InventoryRoute.page,        guards: [AuthGuard()]),
    AutoRoute(page: SearchBarcodeRoute.page,    guards: [AuthGuard()]),
    AutoRoute(page: StockRoute.page,            guards: [AuthGuard()]),
  ];

  //List<AutoRouteGuard> get globalGuards => [AuthGuard()];
}