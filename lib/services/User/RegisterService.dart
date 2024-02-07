import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  static const String url = "http://192.168.15.186/";

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<String> userRegister(String name, String email, String password, String cpf, bool administrator, bool ativo) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: '192.168.15.186',
      port: 8080,
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

    http.Response response = await http.post(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: fields
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }
}