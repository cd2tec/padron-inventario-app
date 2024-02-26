import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart';
import 'package:padron_inventario_app/pages/User/user_management_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'stock_page.dart';
import 'register_page.dart';

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
        actions: [
          PopupMenuButton<String>(
            iconSize: 30,
            onSelected: (value) {
              if (value == 'consultaEstoque') {
                _openStockPage(context);
              } else if (value == 'gerenciarPerfis') {
                _openManageProfilesPage(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Consulta Estoque', 'Gerenciar Perfis'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase().replaceAll(' ', ''),
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        backgroundColor: const Color(0xFFA30000),
      ),
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserListScreen()),
              );
            },
            title: const Text("Gerenciar Usuários"),
            leading: const Icon(Icons.supervised_user_circle),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryPage()),
              );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _openStockPage(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: const Text('Consultar Estoque'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _openManageProfilesPage(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: const Text('Gerenciar Perfis'),
              ),
            ),
            CarouselSlider(
              items: List.generate(10, (index) => _buildStoreItem(index)),
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
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
      Navigator.pushReplacementNamed(context, "login");
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


