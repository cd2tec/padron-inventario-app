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

  final TextEditingController _supplierNameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSupplier();
  }

  Future<void> _fetchSupplier() async {
    List<Supplier> fetchedSupplier = await supplierService.fetchSupplier();
    setState(() {
      supplier = fetchedSupplier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Fornecedores',
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
                      'Consulta Fornecedores',
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
                      'Buscar Fornecedor',
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
                              controller: _supplierNameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nome do Fornecedor',
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _supplierNameController.clear();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      _searchSupplierName(_supplierNameController.text);
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

  Future<void> _searchSupplierName(String supplierName) async {
    if (supplierName.isEmpty) return;
    _searchSupplier('produtoKey', supplierName);
  }

  void _searchSupplier(String filter, String value) {
    setState(() {
      isLoading = true;
    });

    supplierService
        .fetchSupplier(filter, value, selectedSupplier!.nroEmpresaBluesoft!)
        .then((productData) {
      if (productData == null || productData.isEmpty) {
        _handleError("Produto não encontrado.");
        return;
      }

      supplierService
          .fetchStock(filter, value, selectedSupplier!.nroEmpresaBluesoft!)
          .then((stockData) {
        Map<String, dynamic> decodedProductData = jsonDecode(productData);
        Map<String, dynamic> decodedStockData = jsonDecode(stockData);

        Map<String, dynamic> productDataMap = decodedProductData['data'][0];
        Map<String, dynamic> stockDataMap = decodedStockData['data'][0];

        AutoRouter.of(context).replace(InventoryDetailRoute(
            productData: productDataMap, stockData: stockDataMap));
      }).catchError((error) {
        _handleError(error);
      }).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    }).catchError((error) {
      _handleError(error);
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _handleError(dynamic error) {
    if (error is ClientException) {
      final snackBar = SnackBar(
        content: Text(
          _isSupplierNotFoundError(error)
              ? 'Fornecedor não encontrado.'
              : '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text(
          'Problemas ao buscar fornecedor.',
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
