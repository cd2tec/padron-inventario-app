import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:padron_inventario_app/services/AuthService.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService service = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA30000),
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
                LoginButtonWidget(
                  onPressed: _isButtonEnabled ? () => _performLogin(context) : () {},
                  isEnabled: _isButtonEnabled,
                ),
              ],
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

  void _performLogin(BuildContext context) {
    try {
      service.login(
        _usernameController.text,
        _passwordController.text
      ).then((resultLogin) {
        if(resultLogin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      });


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Credenciais inválidas'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
