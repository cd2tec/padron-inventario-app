import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

@RoutePage()
class SupplierProductsPage extends StatefulWidget {
  final List<Map<String, dynamic>> inventory;
  final List<String> updatedGtins;

  const SupplierProductsPage(
      {Key? key, required this.inventory, required this.updatedGtins})
      : super(key: key);

  @override
  _SupplierProductsPageState createState() => _SupplierProductsPageState();
}

class _SupplierProductsPageState extends State<SupplierProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Produtos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.inventory.map((productData) {
                  final product = Product.fromJson(productData);

                  final isUpdated = widget.updatedGtins.contains(product.gtin);

                  return GestureDetector(
                    onTap: () {
                      _navigateToSearchProduct(context);
                    },
                    child: _buildProductItem(product, isUpdated),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product, bool isUpdated) {
    return Card(
      color: isUpdated ? Colors.grey : const Color(0xFFA30000),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                product.descricao,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSearchProduct(BuildContext context) async {
    AutoRouter.of(context).push(
      const SupplierSearchProductRoute(),
    );
  }
}
