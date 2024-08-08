import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/models/Inventory.dart';
import 'package:padron_inventario_app/models/Store.dart';
import 'package:padron_inventario_app/models/User.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/InventoryService.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/services/UserService.dart';
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
  late List<Map<String, dynamic>> products;
  final SupplierService supplierService = SupplierService();
  final InventoryService inventoryService = InventoryService();
  final UserService userService = UserService();

  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _productkeyController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic>? searchedProductData;
  Store? selectedStore;
  int? defaultStore;

  List<Store> stores = [];
  List<User> user = [];

  @override
  void initState() {
    super.initState();
    products = widget.inventory['produtos'] ?? [];
    _fetchUser().then((_) {
      _fetchStores();
    });
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _productkeyController.dispose();
    _quantityController.dispose();
    super.dispose();
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
      defaultStore = fetchedUser.store_id;
    });
  }

  void _showAddConfirmationDialog(int inventoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationAddProductInventory(
          onConfirm: () async {
            await _addProductInventory(
                inventoryId, int.parse(_quantityController.text));
          },
        );
      },
    );
  }

  Future<void> _addProductInventory(int inventoryId, int quantity) async {
    try {
      print('Finalizando inventário $inventoryId com quantidade $quantity');
      // Exemplo de chamada para a API:
      // await supplierService.addProductInventory(inventoryId, quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto adicionado ao inventário com sucesso!'),
        ),
      );

      AutoRouter.of(context).pushAndPopUntil(
        const SupplierRoute(),
        predicate: (route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar o produto ao inventário: $error'),
        ),
      );
    }
  }

  Future<void> _searchProduct(String filter, String value) async {
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

  bool _isProductNotFoundError(http.ClientException error) {
    return error.message.contains("Failed to fetch product.");
  }

  Future<void> _scanProductKey(String productKey) async {
    if (productKey.isEmpty) return;
    _searchProduct('gtin', productKey);
  }

  @override
  Widget build(BuildContext context) {
    final inventory = Inventory.fromJson(widget.inventory);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: AppBarTitle(title: 'Detalhes do ${inventory.descricao}'),
        backgroundColor: const Color(0xFFA30000),
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
                      ),
                      SearchButton(
                        onPressed: () =>
                            _scanProductKey(_productkeyController.text),
                      ),
                    ],
                  ),
                ),
                if (searchedProductData != null)
                  ProductDetail(
                    productData: searchedProductData,
                    quantityController: _quantityController,
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ConfirmButton(
                      onPressed: () => _showAddConfirmationDialog(inventory.id),
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
