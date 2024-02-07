import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _accessToken;

  AuthModel({String? initialToken}) {
    if (initialToken != null) {
      _isLoggedIn = true;
      _accessToken = initialToken;
    }
  }

  bool get isLoggedIn => _isLoggedIn;
  String? get accessToken => _accessToken;

  Future<void> login(String email, String password, {String? initialToken}) async {
    if (initialToken != null) {
      _accessToken = initialToken;
      _isLoggedIn = true;
      notifyListeners();
    }

    var apiUrl = Uri(
      scheme: 'http',
      host: '192.168.15.186',
      port: 8080,
      path: '/login',
    );

    var response = await http.post(apiUrl, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      _accessToken = jsonResponse['access_token'];

      // Armazenar o token no SharedPreferences
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token', _accessToken!);

      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception('Credenciais inválidas');
    }
  }

  void logout() {
    // Adicione a lógica de logout aqui, se necessário

    _isLoggedIn = false;
    _accessToken = null;

    // Limpar o token do SharedPreferences
    SharedPreferences.getInstance().then((prefs) => prefs.remove('token'));

    notifyListeners();
  }
}
