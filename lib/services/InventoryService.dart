import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/Store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryService {

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future fetchProduct(String filter, String code, String store) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8080,
      path: '/inventory',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'lojaKey': store,
         filter: code
      },
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }

  Future fetchStock(String filter, String code, String store) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8080,
      path: '/inventory/stock',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'lojaKey': store,
        filter: code
      },
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }

  Future<List<Store>> fetchStores() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8080,
      path: '/store/allowed/user',
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

    List<dynamic> storeListJson = json.decode(response.body);
    List<Store> storeList = storeListJson.map((storeJson) {
      return Store.fromJson(storeJson);
    }).toList();

    print(storeList);

    return storeList;
  }
}