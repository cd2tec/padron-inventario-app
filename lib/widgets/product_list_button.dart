import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

class ProductListButton extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductListButton({
    Key? key,
    required this.products,
  }) : super(key: key);

  void _navigateToSupplierProductsList(BuildContext context) async {
    await AutoRouter.of(context).push(
      SupplierProductsListRoute(products: products),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateToSupplierProductsList(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFA30000),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: const Text(
        'Visualizar Lista de Produtos',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
