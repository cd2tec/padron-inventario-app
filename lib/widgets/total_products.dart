import 'package:flutter/material.dart';
import 'package:padron_inventario_app/widgets/collected_count_items.dart';
import 'package:padron_inventario_app/widgets/not_collected_count_items.dart';

class TotalProducts extends StatelessWidget {
  final int totalProducts;
  final int collectedProducts;
  final int notCollectedProducts;

  const TotalProducts({
    Key? key,
    required this.totalProducts,
    required this.collectedProducts,
    required this.notCollectedProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total de produtos: $totalProducts',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CollectedCountItems(count: collectedProducts),
            const SizedBox(height: 10),
            NotCollectedCountItems(count: notCollectedProducts),
          ],
        ),
      ),
    );
  }
}
