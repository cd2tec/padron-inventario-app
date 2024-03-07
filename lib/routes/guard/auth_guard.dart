import 'package:auto_route/auto_route.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object loggedIn = prefs.getString('token') ?? false;

    if (loggedIn != false) {
      resolver.next(true);
    } else {
      router.push(LoginRoute(onResult: (result) {
        if (result == true) {
          resolver.next(true);
          router.removeLast();
        }
      }));
    }
  }
}