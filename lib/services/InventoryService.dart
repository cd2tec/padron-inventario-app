import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/Store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryService {
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future fetchInfoProduct(String filter, String code, String store) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8081,
      path: '/inventory/product',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {'lojaKey': store, filter: code},
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }

  Future fetchListProduct(String lojaKey, String gtin) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8081,
      path: '/inventory/product',
    );

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {'lojaKey': lojaKey, 'gtin': gtin},
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
      port: 8081,
      path: '/linker/store',
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

    List<dynamic> userStoreListJson = json.decode(response.body);
    List<Store> storeList = [];

    for (var userStoreJson in userStoreListJson) {
      var storesJson = userStoreJson['stores'] as List<dynamic>;

      for (var storeJson in storesJson) {
        storeList.add(Store.fromJson(storeJson));
      }
    }

    return storeList;
  }

  Future createInventory(
      Map<String, dynamic> data, Map<String, dynamic> product) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8081,
      path: '/inventory',
    );

    var productData = {
      'lojaKey': product['lojaKey'].toString(),
      'produtoKey': product['produtoKey'].toString(),
      'gtin': product['gtin'].toString(),
    };

    var updateData = {...productData, ...data};

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: updateData,
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }
}
