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
      port: 8080,
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

    /* if (response.statusCode != 200) {

      throw http.ClientException(response.body);
    } */

    var supplierInventory = {
      "success": true,
      "message": "Buscando dados localmente!",
      "inventory": [
        {
          "id": 31,
          "supplier_inventory_id": 87,
          "gtin": "7891033926275",
          "descricao": "COND SIAGE 200ML NUTR OURO",
          "quantidade": "0",
          "sequencia": "1",
          "dataValidade": "14/05/2024",
          "loteProduto": null,
          "created_at": "2024-05-14T18:15:50.000000Z",
          "updated_at": "2024-05-14T18:15:50.000000Z"
        },
        {
          "id": 32,
          "supplier_inventory_id": 87,
          "gtin": "7891033935598",
          "descricao": "CR INSTANCE 30G HID MAOS AMORA SILVESTRE",
          "quantidade": "0",
          "sequencia": "2",
          "dataValidade": "14/05/2024",
          "loteProduto": null,
          "created_at": "2024-05-14T18:15:50.000000Z",
          "updated_at": "2024-05-14T18:15:50.000000Z"
        }
      ]
    };
    return supplierInventory['inventory'];
  }

  Future fetchSupplierDetails(String supplier) async {}
}
