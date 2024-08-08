import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/supplier/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/supplier/confirmation_finalize_inventory.dart';
import 'package:padron_inventario_app/widgets/supplier/finalize_button.dart';
import 'package:padron_inventario_app/widgets/supplier/product_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SupplierProductsListPage extends StatefulWidget {
  final Map<String, dynamic> inventory;
  final List<Map<String, dynamic>> products;

  const SupplierProductsListPage({
    Key? key,
    required this.inventory,
    required this.products,
  }) : super(key: key);

  @override
  _SupplierProductsListPageState createState() =>
      _SupplierProductsListPageState();
}

class _SupplierProductsListPageState extends State<SupplierProductsListPage> {
  final SupplierService supplierService = SupplierService();

  void _navigateToSearchProduct(BuildContext context) async {
    await AutoRouter.of(context).push(
      const SupplierSearchProductRoute(),
    );
  }

  void _navigateToProductDetail(
      BuildContext context, Map<String, dynamic> product) {
    AutoRouter.of(context).push(
      SupplierProductDetailRoute(productData: product),
    );
  }

  void _showFinalizeConfirmationDialog(int inventoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationFinalizeInventory(
          onConfirm: () async {
            await _finalizeInventory(inventoryId);
          },
        );
      },
    );
  }

  Future<void> _finalizeInventory(int inventoryId) async {
    bool allProductsValid = true;
    for (var productData in widget.products) {
      final product = Product.fromJson(productData);
      if (product.quantidadeExposicao != null &&
          product.quantidadeExposicao! > 0) {
        allProductsValid = false;
        break;
      }
    }

    if (!allProductsValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Todos os produtos devem ter quantidade maior que zero.'),
        ),
      );
      return;
    }

    Map<String, dynamic> inventory = {...widget.inventory};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      for (var productData in widget.products) {
        final product = Product.fromJson(productData);
        String productKey = product.productKey ?? '';
        String savedData = prefs.getString(productKey) ?? '{}';
        Map<String, dynamic> savedProductData = json.decode(savedData);
        productData.addAll(savedProductData);
      }
      await supplierService.fetchFinalizeInventory(inventoryId, inventory);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inventário finalizado com sucesso!'),
        ),
      );

      AutoRouter.of(context).pushAndPopUntil(
        const SupplierRoute(),
        predicate: (route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao finalizar inventário: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.products.sort((a, b) {
      final productA = Product.fromJson(a);
      final productB = Product.fromJson(b);

      final quantidadeExposicaoA = productA.quantidadeExposicao ?? 0;
      final quantidadeExposicaoB = productB.quantidadeExposicao ?? 0;

      if (quantidadeExposicaoA == 0 && quantidadeExposicaoB > 0) {
        return -1;
      } else if (quantidadeExposicaoA > 0 && quantidadeExposicaoB == 0) {
        return 1;
      } else {
        return 0;
      }
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: 'Lista de Produtos'),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final productData = widget.products[index];
                return ProductList(
                  products: [productData],
                  onTap: (product) =>
                      _navigateToProductDetail(context, product),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FinalizeButton(
              onPressed: () =>
                  _showFinalizeConfirmationDialog(widget.inventory['id']),
            ),
          ),
        ],
      ),
    );
  }
}
