import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:padron_inventario_app/models/Store.dart';
import 'package:padron_inventario_app/models/Supplier.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/services/UserService.dart';
import 'package:padron_inventario_app/widgets/supplier/supplier_list.dart';
import '../../models/User.dart';
import '../../services/InventoryService.dart';

@RoutePage()
class SupplierPage extends StatefulWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  SupplierService supplierService = SupplierService();

  List<Supplier> supplier = [];
  Supplier? selectedSupplier;

  final TextEditingController _supplierInventarioKeyController =
      TextEditingController();
  final TextEditingController _supplierLocalDeEstoqueController =
      TextEditingController();
  final TextEditingController _supplierLoteKeyController =
      TextEditingController();
  bool isLoading = false;
  bool showSupplierList =
      false; // Variável para controlar a visibilidade do SupplierListWidget

  @override
  void initState() {
    super.initState();
    _fetchSupplierInventory();
  }

  Future<void> _fetchSupplierInventory() async {
    try {
      List<Supplier> fetchedSupplier =
          await supplierService.fetchSupplierInventory();
      setState(() {
        supplier = fetchedSupplier;
      });
    } catch (e) {
      throw Exception('Erro ao buscar fornecedor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Inventário por Fornecedor',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Buscar Inventário',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey[300],
                            ),
                            child: TextField(
                              controller: _supplierInventarioKeyController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Chave do Inventário',
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _supplierInventarioKeyController.clear();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey[300],
                            ),
                            child: TextField(
                              controller: _supplierLocalDeEstoqueController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Chave Local de Estoque',
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _supplierLocalDeEstoqueController.clear();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey[300],
                            ),
                            child: TextField(
                              controller: _supplierLoteKeyController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Chave Lote',
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _supplierLoteKeyController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (showSupplierList)
            Container(
              margin: const EdgeInsets.only(top: 300),
              child: SupplierListWidget(
                suppliers: supplier,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                _searchSupplierInventory(
                    _supplierInventarioKeyController.text,
                    _supplierLocalDeEstoqueController.text,
                    _supplierLoteKeyController.text);
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
        ],
      ),
    );
  }

  Future<void> _searchSupplierInventory(
      String inventarioKey, String localDeEstoqueKey, String loteKey) async {
    if (inventarioKey.isEmpty || localDeEstoqueKey.isEmpty || loteKey.isEmpty)
      return;
    _searchSupplier(inventarioKey, localDeEstoqueKey, loteKey);
  }

  void _searchSupplier(
      String inventarioKey, String localDeEstoqueKey, String loteKey) {
    setState(() {
      isLoading = true;
      showSupplierList =
          false; // Ocultar SupplierListWidget antes de iniciar a busca
    });

    _fetchSupplierInventory().then((_) {
      setState(() {
        isLoading = false;
        showSupplierList =
            true; // Exibir SupplierListWidget após a busca ser concluída
      });
    }).catchError((error) {
      _handleError(error);
      setState(() {
        isLoading = false;
        showSupplierList = false; // Ocultar SupplierListWidget em caso de erro
      });
    });
  }

  void _handleError(dynamic error) {
    if (error is ClientException) {
      final snackBar = SnackBar(
        content: Text(
          _isSupplierNotFoundError(error)
              ? 'Inventário de Fornecedor não encontrado.'
              : '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text(
          'Problemas ao buscar inventário do fornecedor.',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _isSupplierNotFoundError(ClientException error) {
    return error.message.contains("Failed to fetch supplier.");
  }

  void _openRegisterPage(BuildContext context) {
    if (ModalRoute.of(context)!.settings.name != "inventory") {
      AutoRouter.of(context).replace(const InventoryRoute());
    }
  }
}
