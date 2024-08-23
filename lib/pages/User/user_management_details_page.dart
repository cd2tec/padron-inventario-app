import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

import '../../services/UserService.dart';

@RoutePage()
class UserDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UserService service = UserService();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  bool isAdmin = false;
  bool ativo = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user['name'] ?? '';
    emailController.text = widget.user['email'] ?? '';
    passwordController.text = widget.user['password'] ?? '';
    cpfController.text = widget.user['cpf'] ?? '';
    isAdmin = widget.user['isAdmin'];
    ativo = widget.user['ativo'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          userDetailsTittle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(redColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${widget.user['id'] ?? ''}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: cpfController,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(labelText: 'CPF'),
                ),
                const SizedBox(height: 16.0),
                CheckboxListTile(
                  title: const Text('Administrador'),
                  value: isAdmin,
                  onChanged: (bool? value) {
                    setState(() {
                      isAdmin = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CheckboxListTile(
                  title: const Text('Ativo'),
                  value: ativo,
                  onChanged: (bool? value) {
                    setState(() {
                      ativo = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 50.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        service
                            .updateUser(
                          widget.user['id'],
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          cpfController.text,
                          isAdmin,
                          ativo,
                        )
                            .then((data) {
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
                      backgroundColor: const Color(redColor),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      'Salvar Alterações',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Você tem certeza que deseja excluir o usuário?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                service.deleteUser(widget.user['id']).then((data) {
                  final snackBar = SnackBar(
                    content: Text(
                      data['message'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.greenAccent,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  AutoRouter.of(context).push(const UserListRoute());
                });
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
