import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

class ProductListButton extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Map<String, dynamic> inventory;

  const ProductListButton({
    Key? key,
    required this.products,
    required this.inventory,
  }) : super(key: key);

  void _navigateToSupplierProductsList(BuildContext context) async {
    await AutoRouter.of(context).push(
      SupplierProductsListRoute(products: products, inventory: inventory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateToSupplierProductsList(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 4, 132, 23),
        minimumSize: const Size(double.infinity, 40),
      ),
      child: const Text(
        'Lista de Itens',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
