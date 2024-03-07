import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:padron_inventario_app/routes/app_router.dart';
import 'package:padron_inventario_app/services/AuthService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env');

  AuthService authService = AuthService();

  bool isLogged = await authService.verifyToken();
  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required bool isLogged});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      routerConfig: appRouter.config(),
    );
  }
}
