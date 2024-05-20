import 'package:auto_route/auto_route.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAdmin = prefs.getBool('isAdmin') ?? false;

    if (isAdmin != false) {
      resolver.next(true);
    } else {
      router.push(HomeRoute());
    }
  }
}