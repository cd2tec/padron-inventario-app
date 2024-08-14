import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Product.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final void Function(Map<String, dynamic> product) onTap;

  const ProductList({
    Key? key,
    required this.products,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: products.map((productData) {
        final product = Product.fromJson(productData);
        return GestureDetector(
          onTap: () => onTap(productData),
          child: Card(
            color: (product.flagUpdated == true)
                ? const Color.fromARGB(255, 4, 132, 23)
                : const Color(0xFFA30000),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          'Código: ${product.productKey}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Quantidade: ${product.saldoDisponivel?.toString()}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
