import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/constants/constants.dart';
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
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _productkeyController.removeListener(_onProductKeyChanged);
    _productkeyController.dispose();
    _quantityController.dispose();
    super.dispose();
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

  Future<void> _loadInventoryDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<Map<String, dynamic>> updatedInventories =
          await supplierService
              .fetchSupplierInventoryById(widget.inventory['id']);

      if (updatedInventories.isNotEmpty) {
        final Map<String, dynamic> inventory = updatedInventories.first;
        setState(() {
          products =
              List<Map<String, dynamic>>.from(inventory['produtos'] ?? []);
        });
      } else {
        setState(() {
          products = [];
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$errorLoadingInventoryDetails $error'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showAddConfirmationDialog(int inventoryId, String storeKey, String gtin,
      String fornecedorKey, Map<String, dynamic>? searchedProductData) {
    bool isUpdating = products.any((product) => product['gtin'] == gtin);

    if (isUpdating) {
      _updateProductInventory(
        inventoryId: inventoryId,
        storeKey: storeKey,
        gtin: gtin,
        fornecedorKey: fornecedorKey,
        estoqueDisponivel: int.parse(_quantityController.text),
      );
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
                description: searchedProductData?['descricao'] ??
                    'Descrição indisponível',
              );
              await _loadInventoryDetails();
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
      required String description}) async {
    try {
      await supplierService.addProductLocalInventory(
          inventoryId: inventoryId,
          storeKey: storeKey,
          gtin: gtin,
          fornecedorKey: fornecedorKey,
          estoqueDisponivel: estoqueDisponivel,
          description: description);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(productAddedToInventorySuccessfully),
        ),
      );
      await supplierService.updateProductLocalInventory(
        inventoryId: inventoryId,
        gtin: gtin,
        estoqueDisponivel: estoqueDisponivel,
      );
      setState(() {
        showProductDetail = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$errorAddingProductToInventory $error'),
        ),
      );
    }
  }

  Future<void> _updateProductInventory(
      {required int inventoryId,
      required String storeKey,
      required String gtin,
      required String fornecedorKey,
      required int estoqueDisponivel}) async {
    try {
      await supplierService.updateProductLocalInventory(
        inventoryId: inventoryId,
        gtin: gtin,
        estoqueDisponivel: estoqueDisponivel,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(productUpdatedInInventorySuccessfully),
        ),
      );
      setState(() {
        showProductDetail = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$errorUpdatingProductInInventory $error'),
        ),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
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
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text(
          problemsSearchingForProduct,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    if (products == null) {
      return const CircularProgressIndicator();
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
                    products: products,
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
