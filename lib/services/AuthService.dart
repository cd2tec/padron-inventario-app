import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String url = "http://192.168.15.186/";

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> login(String email, String password) async {
    var apiUrl = Uri(
      scheme: 'http',
      host: '192.168.15.186',
      port: 8080,
      path: '/login',
    );

    http.Response response = await http.post(
        apiUrl,
        body: {
          'email': email,
          'password': password,
        }
    );

    if(response.statusCode != 200) {
      throw http.ClientException(response.body);
    }
    
    saveUserInfo(response.body);
    return true;
  }

  Future<void> saveUserInfo(String body) async {
    Map<String, dynamic> map = jsonDecode(body);
    String token = map['access_token'];

    SharedPreferences prefs = await getSharedPreferences();
    prefs.setString('token', token);
    String? tokenSave = prefs.getString('token');
    print(tokenSave);
  }

  Future<void> revokeToken() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: '192.168.15.186',
      port: 8080,
      path: '/revoke',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: null
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }
  }
}