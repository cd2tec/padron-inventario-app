import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/user',
    );

    http.Response response = await http.get(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    List<dynamic> data = json.decode(response.body);

    List<Map<String, dynamic>> userList = List<Map<String, dynamic>>.from(data);

    return userList;
  }

  Future<Map<String, dynamic>> updateUser(int userId, String name, String email,
      String password, String cpf, bool isAdmin, bool isActive) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/user/$userId',
    );

    final Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'password': password,
      'cpf': cpf,
      'isAdmin': isAdmin.toString(),
      'ativo': isActive.toString(),
    };

    if (password.isEmpty) {
      userData.remove('password');
    }

    http.Response response = await http.put(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: userData,
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    Map<String, dynamic> data = json.decode(response.body);

    return data;
  }

  Future<String> userRegister(String name, String email, String password,
      String cpf, bool administrator, bool ativo) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/register',
    );

    var fields = {
      'name': name,
      'email': email,
      'password': password,
      'cpf': cpf,
      'isAdmin': administrator.toString(),
      'ativo': ativo.toString(),
    };

    http.Response response = await http.post(apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: fields);

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }

  Future<Map<String, dynamic>> deleteUser(int userId) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/user/${userId}',
    );

    http.Response response = await http.delete(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    Map<String, dynamic> data = json.decode(response.body);

    return data;
  }

  Future<List<dynamic>> hasModulesPermission() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/linker/module',
    );

    http.Response response = await http.get(
      apiUrl,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    return jsonDecode(response.body);
  }

  Future<User> fetchUserData() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/me',
    );

    http.Response response = await http.get(
      apiUrl,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    return User.fromJson(jsonDecode(response.body));
  }
}
