import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InventoryService {
  static const String url = "192.168.15.186";

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future fetchProduct(String filter, String barcode) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: url,
      port: 8080,
      path: '/inventory/$filter/$barcode',
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

    return response.body;
  }
}