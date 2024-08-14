import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/models/Store.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/UserService.dart';

import '../../models/User.dart';
import '../../services/InventoryService.dart';
import '../../widgets/notifications/snackbar_widgets.dart';

@RoutePage()
class SupplierSearchProductPage extends StatefulWidget {
  const SupplierSearchProductPage({Key? key}) : super(key: key);

  @override
  _SupplierSearchProductPageState createState() =>
      _SupplierSearchProductPageState();
}

class _SupplierSearchProductPageState extends State<SupplierSearchProductPage> {
  InventoryService inventoryService = InventoryService();
  UserService userService = UserService();

  List<Store> stores = [];
  List<User> user = [];

  Store? selectedStore;
  int? defaultStore;
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _productkeyController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUser().then((_) {
      _fetchStores();
    });
  }

  Future<void> _fetchStores() async {
    List<Store> fetchedStores = await inventoryService.fetchStores();
    setState(() {
      stores = fetchedStores;

      if (defaultStore != null) {
        selectedStore = stores.firstWhere((store) => store.id == defaultStore);
      }
    });
  }

  Future<void> _fetchUser() async {
    User fetchedUser = await userService.fetchUserData();
    setState(() {
      user.add(fetchedUser);
    });

    setState(() {
      defaultStore = fetchedUser.store_id;
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
          supplierInventoryTitle,
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
                      'Estoque de Produtos',
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
                      'Buscar Produto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _productkeyController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Código do Produto',
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _barcodeController.text.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            "Código de barras: ${_barcodeController.text}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
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
                      _scanProductKey(_productkeyController.text);
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

  Future<void> _scanProductKey(String productkey) async {
    if (productkey.isEmpty) return;
    _searchProduct('gtin', productkey);
  }

  void _searchProduct(String filter, String value) {
    setState(() {
      isLoading = true;
    });

    if (selectedStore!.nroEmpresaBluesoft == null) {
      setState(() {
        isLoading = false;
      });

      const snackBar = SnackBar(
        content: Text(
          'Loja padrão não cadastrada.',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    inventoryService
        .fetchInfoProduct(filter, value, selectedStore!.nroEmpresaBluesoft!)
        .then((productData) {
      var productStatus = jsonDecode(productData);

      if (productStatus.containsKey('error')) {
        final errorSnackBar = ErrorSnackBar(
            message:
                'Houve um problema com a requisição. Por favor, verifique se o token é válido.');
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        return;
      }

      Map<String, dynamic> decodedProductData = jsonDecode(productData);

      AutoRouter.of(context)
          .push(SupplierDetailRoute(productData: decodedProductData));
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
          _isProductNotFoundError(error) ? 'Produto não encontrado.' : '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text(
          'Problemas ao buscar produto.',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _isProductNotFoundError(ClientException error) {
    return error.message.contains("Failed to fetch product.");
  }
}
