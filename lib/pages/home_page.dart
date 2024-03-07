import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart';
import 'package:padron_inventario_app/pages/User/user_management_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_router.gr.dart';
import '../services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'stock_page.dart';
import 'register_page.dart';

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
        title: const Text('Bem-vindo!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            onTap: () {
              AutoRouter.of(context).push(const UserListRoute());
            },
            title: const Text("Gerenciar Usuários"),
            leading: const Icon(Icons.supervised_user_circle),
          ),
          ListTile(
            onTap: () {
              AutoRouter.of(context).push(const InventoryRoute());
            },
            title: const Text("Gerenciar Inventário"),
            leading: const Icon(Icons.inventory),
          ),
          ListTile(
            onTap: () {
              _logout(context);
            },
            title: const Text("Sair"),
            leading: const Icon(Icons.logout),
          )
        ],),),
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

  Widget _buildStoreItem(int index) {
    String storeName =
        'Loja ${index + 1}';

    return GestureDetector(
      onTap: () {
        // _openStoreDetailsPage(context, storeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        color: Colors.green,
        child: Center(
          child: Text(
            storeName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    service.revokeToken(context).then((_) {
      return SharedPreferences.getInstance();
    }).then((prefs) {
      prefs.clear();
      AutoRouter.of(context).push(const LoginRoute());
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

  void _openStockPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StockPage(),
      ),
    );
  }

  void _openManageProfilesPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }
}


