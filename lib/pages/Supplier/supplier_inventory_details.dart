import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/contexts/supplier_products_provider.dart';
import 'package:padron_inventario_app/models/Inventory.dart';
import 'package:padron_inventario_app/models/Store.dart';
import 'package:padron_inventario_app/services/InventoryService.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/notifications/snackbar_widgets.dart';
import 'package:padron_inventario_app/widgets/supplier/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/supplier/confirm_button.dart';
import 'package:padron_inventario_app/widgets/supplier/confirmation_add_product.dart';
import 'package:padron_inventario_app/widgets/supplier/inventory_details.dart';
import 'package:padron_inventario_app/widgets/supplier/items_list_button.dart';
import 'package:padron_inventario_app/widgets/supplier/product_detail.dart';
import 'package:padron_inventario_app/widgets/supplier/product_search_field.dart';
import 'package:padron_inventario_app/widgets/supplier/search_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SupplierInventoryDetailsPage extends StatefulWidget {
  final Map<String, dynamic> inventory;

  const SupplierInventoryDetailsPage({
    Key? key,
    required this.inventory,
  }) : super(key: key);

  @override
  _SupplierInventoryDetailsPageState createState() =>
      _SupplierInventoryDetailsPageState();
}

class _SupplierInventoryDetailsPageState
    extends State<SupplierInventoryDetailsPage> {
  late List<Map<String, dynamic>> products = [];
  final SupplierService supplierService = SupplierService();
  final InventoryService inventoryService = InventoryService();

  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _productkeyController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _productKeyFocusNode = FocusNode();
  bool isLoading = false;
  Map<String, dynamic>? searchedProductData;
  Store? selectedStore;
  int? defaultStore;
  String? _previousProductKey;
  bool showProductDetail = false;

  @override
  void initState() {
    super.initState();
    _loadInventoryDetails();
    _previousProductKey = null;
    _productkeyController.addListener(_onProductKeyChanged);
    _loadAddress();
  }

  Future<void> _loadInventoryDetails() async {
    final provider =
        Provider.of<SupplierProductsProvider>(context, listen: false);
    await provider.loadInventoryDetails(widget.inventory['id']);
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _productkeyController.removeListener(_onProductKeyChanged);
    _productkeyController.dispose();
    _quantityController.dispose();
    _productKeyFocusNode.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool isAddressRequired() {
    final lojaKey = widget.inventory['loja_key'];
    final store = dotenv.env['STORE'];
    return lojaKey == store;
  }

  Future<void> _loadAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedAddress = prefs.getString('savedAddress');
    if (savedAddress != null) {
      setState(() {
        _addressController.text = savedAddress;
      });
    }
  }

  Future<void> _saveAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedAddress', _addressController.text);
  }

  void _onProductKeyChanged() {
    if (_productkeyController.text.length == 13 &&
        _productkeyController.text != _previousProductKey) {
      _previousProductKey = _productkeyController.text;
      _productkeyController.clear();
      _quantityController.clear();
      _scanProductKey(_previousProductKey!);
    }
  }

  Future<void> _showAddConfirmationDialog(
      int inventoryId,
      String storeKey,
      String gtin,
      String fornecedorKey,
      Map<String, dynamic>? searchedProductData) async {
    if (isAddressRequired()) {
      if (_quantityController.text.isEmpty || _addressController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(fillOutAllFields),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      } else {
        if (_quantityController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(fillOutAllFields),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }
      }
    }

    bool isUpdating = products.any((product) => product['gtin'] == gtin);

    if (isUpdating) {
      _updateProductInventory(
        inventoryId: inventoryId,
        storeKey: storeKey,
        gtin: gtin,
        fornecedorKey: fornecedorKey,
        estoqueDisponivel: int.parse(_quantityController.text),
        endereco:
            _addressController.text.isNotEmpty ? _addressController.text : null,
      );
      _saveAddress();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmationAddProductInventory(
            onConfirm: () async {
              await _addProductInventory(
                inventoryId: inventoryId,
                storeKey: storeKey,
                gtin: gtin,
                fornecedorKey: fornecedorKey,
                estoqueDisponivel: int.parse(_quantityController.text),
                endereco: _addressController.text.isNotEmpty
                    ? _addressController.text
                    : null,
                description: searchedProductData?['descricao'] ??
                    'Descrição indisponível',
              );
              await _loadInventoryDetails();
              _saveAddress();
            },
            onCancel: () {
              _productkeyController.clear();
              _quantityController.clear();
              setState(() {
                searchedProductData = null;
                showProductDetail = false;
              });
              _loadInventoryDetails();
            },
          );
        },
      );
    }
  }

  Future<void> _addProductInventory(
      {required int inventoryId,
      required String storeKey,
      required String gtin,
      required String fornecedorKey,
      required int estoqueDisponivel,
      required String description,
      String? endereco}) async {
    try {
      await supplierService.addProductLocalInventory(
          inventoryId: inventoryId,
          storeKey: storeKey,
          gtin: gtin,
          fornecedorKey: fornecedorKey,
          estoqueDisponivel: estoqueDisponivel,
          description: description,
          endereco: endereco);

      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(productAddedToInventorySuccessfully),
            ),
          );
        });
      }

      await supplierService.updateProductLocalInventory(
        inventoryId: inventoryId,
        gtin: gtin,
        estoqueDisponivel: estoqueDisponivel,
      );
      setState(() {
        showProductDetail = false;
      });
    } catch (error) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$errorAddingProductToInventory $error'),
            ),
          );
        });
      }
    }
  }

  Future<void> _updateProductInventory(
      {required int inventoryId,
      required String storeKey,
      required String gtin,
      required String fornecedorKey,
      required int estoqueDisponivel,
      String? endereco}) async {
    try {
      await supplierService.updateProductLocalInventory(
        inventoryId: inventoryId,
        gtin: gtin,
        estoqueDisponivel: estoqueDisponivel,
        endereco:
            _addressController.text.isNotEmpty ? _addressController.text : null,
      );
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(productUpdatedInInventorySuccessfully),
            ),
          );
        });

        setState(() {
          showProductDetail = false;
        });

        await _loadInventoryDetails();
      }
    } catch (error) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$errorAddingProductToInventory $error'),
            ),
          );
        });
      }
    }
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

  Future<void> _searchProduct(String lojaKey, String gtin) async {
    setState(() {
      isLoading = true;
    });

    inventoryService.fetchListProduct(lojaKey, gtin).then((productData) {
      var productStatus = jsonDecode(productData);

      if (productStatus.containsKey('error')) {
        final errorSnackBar = ErrorSnackBar(message: problemWithRequest);
        if (mounted) {
          Future.delayed(const Duration(milliseconds: 100), () {
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
          });
        }

        return;
      }

      setState(() {
        searchedProductData = productStatus;
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
    if (error is http.ClientException) {
      final snackBar = SnackBar(
        content: Text(
          _isProductNotFoundError(error) ? productNotFound : '$error',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else {
      const snackBar = SnackBar(
        content: Text(
          problemsSearchingForProduct,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 100), () {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    }
  }

  bool _isProductNotFoundError(http.ClientException error) {
    return error.message.contains("Failed to fetch product.");
  }

  Future<void> _scanProductKey(String productKey) async {
    if (productKey.isEmpty) return;

    setState(() {
      showProductDetail = true;
    });
    _searchProduct(widget.inventory['loja_key'], productKey);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SupplierProductsProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.products.isEmpty) {
      return const Center(child: Text('Nenhum produto encontrado.'));
    }

    final inventory = Inventory.fromJson(widget.inventory);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: AppBarTitle(title: 'Detalhes do ${inventory.descricao}'),
        backgroundColor: const Color(redColor),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InventoryDetails(
                  descricao: inventory.descricao,
                  lojaKey: inventory.lojaKey,
                  fornecedorKey: inventory.fornecedorKey,
                  divisao: inventory.divisao,
                  status: inventory.status,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ProductSearchField(
                        productKeyController: _productkeyController,
                        barcodeController: _barcodeController,
                        focusNode: _productKeyFocusNode,
                        onScan: _scanBarcode,
                        onSubmit: (value) {
                          _scanProductKey(value);
                        },
                      ),
                      SearchButton(
                        onPressed: () =>
                            _scanProductKey(_productkeyController.text),
                      ),
                    ],
                  ),
                ),
                if (showProductDetail && searchedProductData != null)
                  Column(
                    children: [
                      ProductDetail(
                        productData: searchedProductData,
                        quantityController: _quantityController,
                        onSubmitQuantity: (value) {
                          _showAddConfirmationDialog(
                              inventory.id,
                              inventory.lojaKey,
                              _previousProductKey!,
                              inventory.fornecedorKey,
                              searchedProductData);
                        },
                      ),
                      if (isAddressRequired())
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _addressController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Endereço',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _saveAddress();
                            },
                          ),
                        ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ConfirmButton(
                      onPressed: () => _showAddConfirmationDialog(
                          inventory.id,
                          inventory.lojaKey,
                          _previousProductKey!,
                          inventory.fornecedorKey,
                          searchedProductData),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ItemsListButton(
                    products: provider.products,
                    inventory: widget.inventory,
                  ),
                ),
              ],
            ),
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
}
