import 'package:delmoro_estoque_app/pages/home_page.dart';
import 'package:delmoro_estoque_app/pages/login_page.dart';
import 'package:delmoro_estoque_app/pages/register_page.dart';
import 'package:delmoro_estoque_app/pages/User/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLogged = await verifyToken();
  runApp(MyApp(isLogged: isLogged,));
}

Future<bool> verifyToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if(token != null) {
    return true;
  }

  return false;
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
      },
    );
  }
}
