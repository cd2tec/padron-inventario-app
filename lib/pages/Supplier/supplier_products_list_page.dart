import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/supplier/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/supplier/confirmation_finalize_inventory.dart';
import 'package:padron_inventario_app/widgets/supplier/finalize_button.dart';
import 'package:padron_inventario_app/widgets/supplier/product_list.dart';

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
      SupplierProductDetailRoute(
        productData: product,
        additionalData: {
          'inventoryId': widget.inventory['id'],
          'products': widget.products,
        },
      ),
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

      if (product.flagUpdated == false) {
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

      final flgUpdatedA = productA.flagUpdated ?? true;
      final flgUpdatedB = productB.flagUpdated ?? true;

      if (!flgUpdatedA && flgUpdatedB) {
        return -1;
      } else if (flgUpdatedA && !flgUpdatedB) {
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
        title: const AppBarTitle(title: productsListTitle),
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
                final product = Product.fromJson(productData);

                return Container(
                  color: product.flagUpdated == false
                      ? Colors.red[100]
                      : Colors.transparent,
                  child: ProductList(
                    products: [productData],
                    onTap: (product) =>
                        _navigateToProductDetail(context, product),
                  ),
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