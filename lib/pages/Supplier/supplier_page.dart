import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/Inventory.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/services/UserService.dart';
import 'package:padron_inventario_app/widgets/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/inventory_list.dart';
import 'package:padron_inventario_app/widgets/loader_overlay.dart';

import '../../widgets/notifications/snackbar_widgets.dart';

@RoutePage()
class SupplierPage extends StatefulWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  SupplierService supplierService = SupplierService();
  UserService userService = UserService();

  bool isLoading = false;
  List<Map<String, dynamic>> inventories = [];

  @override
  void initState() {
    super.initState();
    _fetchInventoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: 'Inventários por Fornecedor'),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: LoaderOverlay(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InventoryList(
              inventories: inventories,
              onTap: (inventory) =>
                  _navigateToInventoryDetails(context, inventory),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToInventoryDetails(
      BuildContext context, Inventory inventory) async {
    await AutoRouter.of(context).push(
      SupplierInventoryDetailsRoute(inventory: inventory.toJson()),
    );
  }

  Future<void> _fetchInventoriesList() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Map<String, dynamic>> fetchedInventories =
          await supplierService.fetchSupplierInventoriesList();

      setState(() {
        inventories = fetchedInventories;
      });
    } catch (error) {
      if (error is http.ClientException) {
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(message: formatMessage(error.message)),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    try {
      List<Map<String, dynamic>> mockInventories = [
        {
          'id': 1,
          'descricao': 'Inventário 1',
          'loja_key': 'loja1',
          'fornecedor_key': 'fornecedor1',
          'divisao': 'Divisão 1',
          'status': 'Em Aberto',
          'produtos': [
            {
              "id": 1,
              "inventory_id": 2,
              "product_key": 1,
              "gtin": 3,
              "descricao": 'Produto 1',
              "coletado": "Sim",
              "quantidade_exposicao": 4,
              "quantidade_ponto_extra": 5,
              "saldo_disponivel": "2.4",
              "multiplo": 6,
              "created_at": "2024-07-03T16:16:37.000000Z",
              "updated_at": "2024-07-03T16:16:37.000000Z"
            },
            {
              "id": 2,
              "inventory_id": 2,
              "product_key": 2,
              "gtin": 3,
              "descricao": 'Produto 2',
              "coletado": "Não",
              "quantidade_exposicao": 4,
              "quantidade_ponto_extra": 5,
              "saldo_disponivel": "2.4",
              "multiplo": 6,
              "created_at": "2024-07-03T16:16:37.000000Z",
              "updated_at": "2024-07-03T16:16:37.000000Z"
            }
          ],
          "created_at": "2024-06-26T21:41:01.000000Z",
          "updated_at": "2024-07-01T00:51:34.000000Z"
        },
        {
          "id": 2,
          "descricao": 'Inventário 2',
          "divisao": 'Divisão 2',
          "loja_key": '13',
          "fornecedor_key": '2',
          "status": 'Em aberto',
          "produtos": [
            {
              "id": 1,
              "inventory_id": 2,
              "product_key": 1,
              "gtin": 3,
              "descricao": 'Produto 1',
              "coletado": "Sim",
              "quantidade_exposicao": 4,
              "quantidade_ponto_extra": 5,
              "saldo_disponivel": "2.4",
              "multiplo": 6,
              "created_at": "2024-07-03T16:16:37.000000Z",
              "updated_at": "2024-07-03T16:16:37.000000Z"
            },
            {
              "id": 2,
              "inventory_id": 2,
              "product_key": 2,
              "gtin": 3,
              "descricao": 'Produto 2',
              "coletado": "Não",
              "quantidade_exposicao": 4,
              "quantidade_ponto_extra": 5,
              "saldo_disponivel": "2.4",
              "multiplo": 6,
              "created_at": "2024-07-03T16:16:37.000000Z",
              "updated_at": "2024-07-03T16:16:37.000000Z"
            },
          ],
          "created_at": "2024-06-26T21:41:01.000000Z",
          "updated_at": "2024-07-01T00:51:34.000000Z"
        }
        // Adicione outros mockInventories aqui
      ];

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        inventories = mockInventories;
      });
    } catch (error) {
      if (error is http.ClientException) {
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(message: formatMessage(error.message)),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatMessage(String message) {
    Map<String, dynamic> decodedResponse = jsonDecode(message);
    return decodedResponse['message'];
  }
}
