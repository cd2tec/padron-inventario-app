import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:padron_inventario_app/models/Store.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/UserService.dart';
import '../../models/User.dart';
import '../../services/InventoryService.dart';

@RoutePage()
class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
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
          'Inventário',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _openRegisterPage(context);
            },
          ),
        ],
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
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey[300],
                            ),
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
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () {
                            _scanBarcode();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Selecionar Loja',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) =>
                                value == null ? "Selecione uma loja" : null,
                                items: [
                                  ...stores.map((Store loja) {
                                    return DropdownMenuItem<Store>(
                                      value: loja,
                                      child: Center(
                                        child: Text(loja.fantasia),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (Store? newValue) {
                                  setState(() {
                                    selectedStore = newValue;
                                  });
                                },
                                value: selectedStore,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

  Future<void> _scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancelar",
      true,
      ScanMode.DEFAULT,
    );

    if (!mounted) return;
    _productkeyController.text = barcodeScanRes;

    _scanProductKey(_productkeyController.text);
  }

  Future<void> _scanProductKey(String productkey) async {
    if (productkey.isEmpty) return;
    _searchProduct('produtoKey', productkey);
  }

  void _searchProduct(String filter, String value) {
    setState(() {
      isLoading = true;
    });

    inventoryService.fetchProduct(filter, value, selectedStore!.nroEmpresaBluesoft!).then((productData) {
      inventoryService.fetchStock(filter, value, selectedStore!.nroEmpresaBluesoft!).then((stockData) {
        Map<String, dynamic> decodedProductData = jsonDecode(productData);
        Map<String, dynamic> decodedStockData = jsonDecode(stockData);

        Map<String, dynamic> productDataMap = decodedProductData['data'][0];
        Map<String, dynamic> stockDataMap = decodedStockData['data'][0];

        AutoRouter.of(context).replace(InventoryDetailRoute(productData: productDataMap, stockData: stockDataMap));
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
          _isProductNotFoundError(error) ? 'Produto não encontrado.' : '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(
          '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool _isProductNotFoundError(ClientException error) {
    return error.message.contains("Failed to fetch product.");
  }

  void _openRegisterPage(BuildContext context) {
    if (ModalRoute.of(context)!.settings.name != "inventory") {
      AutoRouter.of(context).replace(const InventoryRoute());
    }
  }
}
