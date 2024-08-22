import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/services/UserService.dart';

import '../../routes/app_router.gr.dart';

@RoutePage()
class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserService service = UserService();
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      List<dynamic> fetchedUsers = await service.fetchUsers();

      setState(() {
        users = fetchedUsers;
        filteredUsers = List.from(users);
      });
    } catch (error) {
      final snackBar = SnackBar(
        content: Text(
          '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) =>
              user['name'].toLowerCase().contains(query.toLowerCase()) ||
              user['email'].toLowerCase().contains(query.toLowerCase()) ||
              user['id'].toString().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          userManagerTittle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            iconSize: 30,
            onSelected: (value) {
              if (value == 'cadastrarusuario') {
                _openRegisterPage(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Cadastrar Usuario'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase().replaceAll(' ', ''),
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        backgroundColor: const Color(redColor),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                _filterUsers(value);
              },
              decoration: const InputDecoration(
                labelText: 'Pesquisar por Nome/Email/ID',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredUsers[index]['name']),
                  subtitle: Text(filteredUsers[index]['email']),
                  onTap: () {
                    AutoRouter.of(context)
                        .push(UserDetailsRoute(user: filteredUsers[index]));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openRegisterPage(BuildContext context) {
    if (ModalRoute.of(context)!.settings.name != "register") {
      AutoRouter.of(context).push(const RegisterRoute());
    }
  }
}
