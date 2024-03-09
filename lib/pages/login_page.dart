import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
          widget.onResult.call(true);
          AutoRouter.of(context).push(HomeRoute());
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
