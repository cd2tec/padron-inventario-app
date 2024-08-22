import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/AuthService.dart';

import '../widgets/widgets.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  final Function(bool?) onResult;
  const LoginPage({Key? key, required this.onResult});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService service = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isButtonEnabled = false;
  Future<bool?>? _loginFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(redColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 100),
            Column(
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
                _buildLoginButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return _isButtonEnabled
        ? FutureBuilder<bool?>(
            future: _loginFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return LoginButtonWidget(
                  onPressed: () => _performLogin(context),
                  isEnabled: _isButtonEnabled,
                );
              }
            },
          )
        : LoginButtonWidget(
            onPressed: () {},
            isEnabled: _isButtonEnabled,
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

  void _performLogin(BuildContext context) {
    setState(() {
      _loginFuture = service.login(
        _usernameController.text,
        _passwordController.text,
      );
    });

    _loginFuture!.then((resultLogin) {
      if (resultLogin != null && resultLogin) {
        widget.onResult.call(true);
        AutoRouter.of(context).push(HomeRoute());
      }
    }).catchError((error, stackTrace) {
      if (error is http.ClientException) {
        Map<String, dynamic> errorMap = jsonDecode(error.message);
        int statusCode = errorMap['statusCode'];
        String errorMessage = errorMap['message'];

        if (statusCode == 401) {
          _showErrorSnackbar(context, errorMessage);
        }
      }
    });
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(errorMessage),
      ),
    );
  }
}
