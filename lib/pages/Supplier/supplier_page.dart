import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/services/UserService.dart';
import '../../models/Supplier.dart';
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

  final TextEditingController _inventarioController = TextEditingController();
  final TextEditingController _localDeEstoqueController = TextEditingController();
  final TextEditingController _loteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Inventário Fornecedor',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Buscar Inventário',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Código Inventário',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey[300],
                            ),
                            child: TextField(
                              controller: _inventarioController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Código Inventário',
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Local De Estoque',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey[300],
                            ),
                            child: TextField(
                              controller: _localDeEstoqueController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Local de Estoque',
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Código Lote',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey[300],
                            ),
                            child: TextField(
                              controller: _loteController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Lote',
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      _fetchInventory();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA30000),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _fetchInventory() async {
    if (_inventarioController.text.isEmpty
        || _localDeEstoqueController.text.isEmpty
        || _loteController.text.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(message: 'Preencha todos os campos!')
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    Supplier supplier = Supplier(
      inventarioKey: _inventarioController.text,
      localEstoque: _localDeEstoqueController.text,
      loteKey: _loteController.text,
    );

    _fetchSupplierInventory(supplier, context);
  }

  Future<void> _fetchSupplierInventory(Supplier supplier, context) async {
    try {
      var supplierResp = await supplierService.fetchSupplierInventory(supplier);
      print(supplierResp);

      ScaffoldMessenger.of(context).showSnackBar(
          SuccessSnackBar(message: formatMessage(supplierResp))
      );

      return supplierResp;
    } catch (error) {
      if (error is http.ClientException) {
        ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(message: formatMessage(error.message))
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
