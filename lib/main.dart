import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:padron_inventario_app/routes/app_router.dart';
import 'package:padron_inventario_app/services/AppLifecycleService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  runApp(const MyApp());
}

@RoutePage()
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return AppLifecycleManager(
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
      ),
    );
  }
}
