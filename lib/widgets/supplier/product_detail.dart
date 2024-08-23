import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';

class ProductDetail extends StatelessWidget {
  final Map<String, dynamic>? productData;
  final TextEditingController quantityController;

  const ProductDetail({
    Key? key,
    this.productData,
    required this.quantityController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (productData == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            color: const Color(redColor),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$descriptionTittle ${productData!['descricao'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Código do Produto: ${productData!['produtoKey'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Loja (Bluesoft): ${productData!['lojaKey'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'GTIN: ${productData!['gtinPrincipal'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantidade',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
