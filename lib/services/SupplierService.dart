import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/Supplier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierService {
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<List<Map<String, dynamic>>> fetchSupplierInventoriesList() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8081,
      path: '/inventory/local/index',
    );

    http.Response response = await http.get(apiUrl, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json; charset=utf-8',
    });

    print(response.body);

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> inventoryDynamic = jsonResponse['data'];

    DateTime now = DateTime.now();
    DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));

    List<Map<String, dynamic>> inventory = inventoryDynamic
        .map((item) => item as Map<String, dynamic>)
        .where((item) {
      DateTime createdAt = DateTime.parse(item['created_at']);
      return item['status'] == 'PENDENTE' && createdAt.isAfter(thirtyDaysAgo);
    }).toList();

    return inventory;
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

  Future<void> fetchFinalizeInventory(
      int inventoryId, Map<String, dynamic> inventory) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8081,
      path: '/inventory/supplier',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to finalize inventory');
    }
  }

  Future<void> addProductLocalInventory(
      int inventoryId, Map<String, dynamic> inventory) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8081,
      path: '/inventory/local/product-inventory',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to finalize inventory');
    }
  }
}
