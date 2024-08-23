import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/services/UserService.dart';
import 'package:padron_inventario_app/widgets/register/register_check_box.dart';
import 'package:padron_inventario_app/widgets/register/register_text_field.dart';

import '../../routes/app_router.gr.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  UserService service = UserService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  bool _isAdmin = false;
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RegisterTextField(
            label: 'Nome Completo',
            controller: _nomeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite seu nome completo';
              }
              return null;
            },
            icon: const Icon(Icons.supervised_user_circle_outlined),
          ),
          const SizedBox(height: 16.0),
          RegisterTextField(
            label: 'Email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite seu email';
              }
              return null;
            },
            icon: const Icon(Icons.email),
          ),
          const SizedBox(height: 16.0),
          RegisterTextField(
            label: 'Senha',
            controller: _senhaController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite sua senha';
              }
              return null;
            },
            icon: const Icon(Icons.password),
          ),
          const SizedBox(height: 16.0),
          RegisterTextField(
            label: 'CPF',
            controller: _cpfController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, digite seu CPF';
              }
              return null;
            },
            icon: const Icon(Icons.credit_card),
          ),
          const SizedBox(height: 16.0),
          RegisterCheckBox(
            label: 'Administrador',
            value: _isAdmin,
            onChanged: (value) {
              setState(() {
                _isAdmin = value ?? false;
              });
            },
          ),
          const SizedBox(height: 16.0),
          RegisterCheckBox(
            label: 'Ativo',
            value: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value ?? false;
              });
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                String name = _nomeController.text;
                String email = _emailController.text;
                String password = _senhaController.text;
                String cpf = _cpfController.text;
                bool administrator = _isAdmin;
                bool ativo = _isActive;

                service
                    .userRegister(
                        name, email, password, cpf, administrator, ativo)
                    .then((response) {
                  Map<String, dynamic> data = jsonDecode(response);

                  final snackBar = SnackBar(
                    content: Text(
                      data['message'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  AutoRouter.of(context).push(const UserListRoute());
                }).catchError((error) {
                  final snackBar = SnackBar(
                    content: Text(
                      '$error',
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.redAccent,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              backgroundColor: const Color(redColor),
            ),
            child: const Text(
              registerTittle,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
