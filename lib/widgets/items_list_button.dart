import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

class ItemsListButton extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ItemsListButton({Key? key, required this.products}) : super(key: key);

  void _navigateToSupplierProductsList(BuildContext context) async {
    await AutoRouter.of(context).push(
      SupplierProductsListRoute(products: products),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => _navigateToSupplierProductsList(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 4, 132, 23),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          minimumSize: const Size(double.infinity, 60),
        ),
        child: const Text(
          'Lista de Itens',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
