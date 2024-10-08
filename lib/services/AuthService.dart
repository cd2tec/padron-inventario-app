import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String?> getIpAddress() async {
    return dotenv.env['API_SERVER_IP'];
  }

  Future<bool> login(String email, String password) async {
    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/login',
    );

    http.Response response = await http.post(apiUrl, body: {
      'name': email,
      'password': password,
    });

    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        Map<String, dynamic> errorMap = {
          'message': 'Credenciais inválidas!',
          'statusCode': response.statusCode,
        };
        throw http.ClientException(jsonEncode(errorMap));
      }

      throw http.ClientException(response.body);
    }

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    saveUserInfo(response.body);
    return true;
  }

  Future<void> saveUserInfo(String body) async {
    Map<String, dynamic> map = jsonDecode(body);
    String token = map['access_token'];
    bool isAdmin = map['isAdmin'];

    SharedPreferences prefs = await getSharedPreferences();
    prefs.setString('token', token);
    prefs.setBool('isAdmin', isAdmin);
  }

  Future<bool> verifyToken() async {
    SharedPreferences prefs = await getSharedPreferences();
    String? token = prefs.getString('token');

    if (token != null) {
      return true;
    }

    return false;
  }

  Future<void> revokeToken(context) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: int.parse(dotenv.env['API_SERVER_PORT'] ?? '0'),
      path: '/revoke',
    );

    http.Response response = await http.post(apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json'
        },
        body: null);

    if (response.statusCode != 200) {
      prefs.clear();
      AutoRouter.of(context).replace(LoginRoute(onResult: (result) {
        return false;
      }));

      throw http.ClientException(response.body);
    }

    AutoRouter.of(context).replace(LoginRoute(onResult: (result) {
      return false;
    }));
  }
}
