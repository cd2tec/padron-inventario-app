import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../widgets/register/register_form.dart';
import 'stock_page.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Cadastrar Usuário',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Center(
            child: RegisterForm(),
          ),
        ),
      ),
    );
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
    // Não faz nada, já estamos na página de Gerenciar Perfis
  }
}
