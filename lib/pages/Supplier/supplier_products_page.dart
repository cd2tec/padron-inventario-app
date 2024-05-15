import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

@RoutePage()
class SupplierProductsPage extends StatefulWidget {
  final List<Map<String, dynamic>> inventory;
  final List<int> confirmedProductIds;

  const SupplierProductsPage(
      {Key? key, required this.inventory, required this.confirmedProductIds})
      : super(key: key);

  @override
  _SupplierProductsPageState createState() => _SupplierProductsPageState();
}

class _SupplierProductsPageState extends State<SupplierProductsPage> {
  Set<String> confirmedProducts = {};

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
                  final isConfirmed =
                      widget.confirmedProductIds.contains((product.id));
                  return GestureDetector(
                    onTap: () {
                      _navigateToSearchProduct(context, product);
                    },
                    child: _buildProductItem(product, isConfirmed),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product, bool isConfirmed) {
    return Card(
      color: isConfirmed
          ? Colors.grey
          : const Color(
              0xFFA30000), // Mudar a cor se o produto estiver confirmado
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

  void _navigateToSearchProduct(BuildContext context, Product product) async {
    final confirmedProductId = await AutoRouter.of(context).push<int>(
      const SupplierSearchProductRoute(),
    );

    if (confirmedProductId != null) {
      // Atualizar o estado para refletir a confirmação do produto
      setState(() {
        widget.confirmedProductIds.add(confirmedProductId);
      });
    }
  }
}
