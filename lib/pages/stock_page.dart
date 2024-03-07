import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';

@RoutePage()
class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Estoque'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'consultaEstoque') {
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
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('Página de Consulta de Estoque'),
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
