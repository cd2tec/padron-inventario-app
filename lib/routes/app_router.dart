import 'package:auto_route/auto_route.dart';
import 'package:padron_inventario_app/routes/guard/module_guard.dart';
import 'package:padron_inventario_app/routes/guard/permission_guard.dart';
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
    AutoRoute(page: InventoryDetailRoute.page,  guards: [AuthGuard(), ModuleGuard(selectedModule: 'inventory')]),
    AutoRoute(page: InventoryRoute.page,        guards: [AuthGuard(), ModuleGuard(selectedModule: 'inventory')]),

    // Supplier
    AutoRoute(page: SupplierRoute.page, guards: [AuthGuard(), ModuleGuard(selectedModule: 'inventory')]),

    // Mapping Keys
    //AutoRoute(page: MappingKeysRoute.page,      guards: [AuthGuard()]),
  ];

  //List<AutoRouteGuard> get globalGuards => [AuthGuard()];
}