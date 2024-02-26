import 'package:padron_inventario_app/pages/Inventory/inventory_detail_page.dart';
import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart';
import 'package:padron_inventario_app/pages/home_page.dart';
import 'package:padron_inventario_app/pages/login_page.dart';
import 'package:padron_inventario_app/pages/register_page.dart';
import 'package:padron_inventario_app/pages/User/user_management_page.dart';
import 'package:padron_inventario_app/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService authService = AuthService();

  bool isLogged = await authService.verifyToken();
  runApp(MyApp(isLogged: isLogged,));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({Key? key, required this.isLogged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isLogged ? "home" : "login",
      routes: {
        "home": (context) => HomePage(),
        "login": (context) => const LoginPage(),
        "register": (context) => const RegisterPage(),
        "user": (context) => const UserListScreen(),
        "inventory": (context) => InventoryPage(),
        "inventory/detail": (context) => InventoryDetailPage()
      },
    );
  }
}
