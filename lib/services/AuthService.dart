import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
  }

  Future<bool> verifyToken() async{
    SharedPreferences prefs = await getSharedPreferences();
    String? token = prefs.getString('token');

    if(token != null) {
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
      port: 8080,
      path: '/revoke',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: null
    );

    if (response.statusCode != 200) {
      if(response.statusCode == 401) {
        prefs.clear();
        Navigator.pushReplacementNamed(context, "login");
      }
      throw http.ClientException(response.body);
    }
  }
}