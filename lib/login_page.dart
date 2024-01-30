import 'dart:developer';

import 'package:delmoro_estoque_app/home_page.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UsernameInputWidget(
                    controller: _usernameController,
                    onChanged: _updateButtonState,
                  ),
                  const SizedBox(height: 16),
                  PasswordInputWidget(
                    controller: _passwordController,
                    onChanged: _updateButtonState,
                    obscureText: _obscurePassword,
                    onToggle: _togglePasswordVisibility,
                  ),
                  const SizedBox(height: 24),
                  LoginButtonWidget(
                    onPressed: _isButtonEnabled ? login : () {},
                    isEnabled: _isButtonEnabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  login() async {
    var apiUrl = Uri.parse('http://144.22.160.136:8081/login/mobile');

    var response = await http.post(apiUrl, body: {
      'sequsuario': _usernameController.text,
      'password': _passwordController.text,
      'mobiletoken': '123456'
    });

    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: _usernameController.text),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Usuário ou senha inválidos'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
