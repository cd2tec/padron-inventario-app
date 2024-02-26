import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/Store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryService {
  static const String url = "192.168.15.186";

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future fetchProduct(String filter, String code, String store) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');
    print(store);

    var apiUrl = Uri(
      scheme: 'http',
      host: url,
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

  Future<List<Store>> fetchStores() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');


    var apiUrl = Uri(
      scheme: 'http',
      host: url,
      port: 8080,
      path: '/store/allowed',
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