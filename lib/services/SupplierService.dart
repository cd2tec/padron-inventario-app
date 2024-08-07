import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Supplier.dart';

class SupplierService {
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future fetchSupplierInventory(Supplier supplier) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8081,
      path: '/inventory/supplier',
    );

    var requestBody = {
      'inventarioKey': supplier.inventarioKey,
      'localEstoque': supplier.localEstoque,
      'loteKey': supplier.loteKey,
    };

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json; charset=utf-8',
      },
      body: requestBody,
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    List<dynamic> inventoryDynamic = jsonResponse['inventory'];

    List<Map<String, dynamic>> inventory =
        inventoryDynamic.map((item) => item as Map<String, dynamic>).toList();

    return inventory;
  }
}
