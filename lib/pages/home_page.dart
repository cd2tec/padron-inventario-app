import 'package:auto_route/auto_route.dart';
import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart';
import 'package:padron_inventario_app/pages/User/user_management_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/pages/stock_page.dart';
import 'package:padron_inventario_app/pages/register_page.dart';
import 'package:padron_inventario_app/services/AuthService.dart';

import '../routes/guard/module_guard.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final AuthService service = AuthService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Bem-vindo!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      drawer: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bool isAdmin = snapshot.data?.getBool('isAdmin') ?? false;

            return buildDrawer(context, isAdmin);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Padron',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Perfumaria',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'APP Inventário V1.0',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Versão Debug',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context, bool isAdmin) {
    return Drawer(
      child: ListView(
        children: [
          if (isAdmin)
            ListTile(
              onTap: () {
                AutoRouter.of(context).push(const UserListRoute());
              },
              title: const Text("Gerenciar Usuários"),
              leading: const Icon(Icons.supervised_user_circle),
            ),
          ListTile(
            onTap: () {
              AutoRouter.of(context)
                  .push(const InventoryRoute())
                  .catchError((error) {
                Navigator.pop(context);
              });
            },
            title: const Text("Gerenciar Inventário"),
            leading: const Icon(Icons.inventory),
          ),
          ListTile(
            onTap: () {
              AutoRouter.of(context)
                  .push(const SupplierRoute())
                  .catchError((error) {
                Navigator.pop(context);
              });
            },
            title: const Text("Consulta Fornecedores"),
            leading: const Icon(Icons.business),
          ),
          ListTile(
            onTap: () {
              _logout(context);
            },
            title: const Text("Sair"),
            leading: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    service.revokeToken(context).then((_) {
      return SharedPreferences.getInstance();
    }).then((prefs) {
      prefs.clear();
    }).catchError((error) {
      final snackBar = SnackBar(
        content: Text(
          'Ocorreu um erro durante o logout: $error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
