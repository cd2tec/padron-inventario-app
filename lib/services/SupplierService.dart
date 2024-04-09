import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/Store.dart';
import 'package:padron_inventario_app/models/Supplier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierService {
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
      body: {'lojaKey': store, filter: code},
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }

  Future<List<Supplier>> fetchSupplier() async {
    await Future.delayed(Duration(seconds: 2));

    return [
      Supplier(
          id: 1,
          razaoSocial: 'Fornecedor 1',
          fantasia: 'Fornecedor 1',
          cnpj: '00100123000123',
          cidade: 'Brasilia',
          uf: 'DF',
          telefone: '61992651358',
          nroEmpresaBluesoft: '123',
          cd: true),
      Supplier(
          id: 2,
          razaoSocial: 'Fornecedor 2',
          fantasia: 'Fornecedor 1',
          cnpj: '00100123000123',
          cidade: 'Brasilia',
          uf: 'DF',
          telefone: '61992651358',
          nroEmpresaBluesoft: '123',
          cd: true),
      Supplier(
          id: 3,
          razaoSocial: 'Fornecedor 3',
          fantasia: 'Fornecedor 1',
          cnpj: '00100123000123',
          cidade: 'Brasilia',
          uf: 'DF',
          telefone: '61992651358',
          nroEmpresaBluesoft: '123',
          cd: true),
    ];
  }

  /* Future<List<Supplier>> fetchSupplier() async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8080,
      path: '/supplier',
    );

    try {
      http.Response response = await http.get(
        apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 404) {
          throw Exception('Rota não encontrada: /supplier');
        }
        throw http.ClientException(response.body);
      }

      List<dynamic> userStoreListJson = json.decode(response.body);
      List<Supplier> supplierList = [];

      for (var userStoreJson in userStoreListJson) {
        var storesJson = userStoreJson['stores'] as List<dynamic>;

        for (var storeJson in storesJson) {
          supplierList.add(Supplier.fromJson(storeJson));
        }
      }

      return supplierList;
    } catch (e) {
      throw Exception('Erro ao buscar fornecedor: $e');
    }
  } */

  Future createInventory(
      Map<String, dynamic> data, Map<String, dynamic> product) async {
    SharedPreferences prefs = await getSharedPreferences();
    var token = prefs.getString('token');

    var apiUrl = Uri(
      scheme: 'http',
      host: dotenv.env['API_SERVER_IP'],
      port: 8080,
      path: '/inventory',
    );

    data = {
      'lojaKey': product['lojaKey'].toString(),
      'productKey': product['productKey'].toString(),
      'gtin': product['gtin'].toString(),
      'fields': jsonEncode(data)
    };

    http.Response response = await http.post(
      apiUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode != 200) {
      throw http.ClientException(response.body);
    }

    return response.body;
  }
}
