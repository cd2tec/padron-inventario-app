import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        'images/logopadron.png',
        height: 90,
        width: 300,
      ),
    );
  }
}

class UsernameInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;

  const UsernameInputWidget({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Usuário',
        prefixIcon: const Icon(Icons.supervised_user_circle_outlined),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (value) => onChanged(),
    );
  }
}

class PasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final bool obscureText;
  final Function onToggle;

  const PasswordInputWidget({super.key, 
    required this.controller,
    required this.onChanged,
    required this.obscureText,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Senha',
        prefixIcon: const Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () => onToggle(),
        ),
      ),
      obscureText: obscureText,
      onChanged: (value) => onChanged(),
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  final Function onPressed;
  final bool isEnabled;

  const LoginButtonWidget({
    Key? key,
    required this.onPressed,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? () => onPressed() : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isEnabled ? Colors.white : Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: const Text('Acessar'),
    );
  }
}


