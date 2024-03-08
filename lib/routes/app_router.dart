import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: InventoryDetailRoute.page),
    AutoRoute(page: InventoryRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: SearchBarcodeRoute.page),
    AutoRoute(page: StockRoute.page),
    AutoRoute(page: UserDetailsRoute.page),
    AutoRoute(page: UserListRoute.page),
  ];
}