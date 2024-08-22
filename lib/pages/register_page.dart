import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';

import '../widgets/register/register_form.dart';

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
        title: const Text(
          registerUserTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(redColor),
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
}
