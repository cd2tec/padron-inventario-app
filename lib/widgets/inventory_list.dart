import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Inventory.dart';

class InventoryList extends StatelessWidget {
  final List<Map<String, dynamic>> inventories;
  final Function(Inventory) onTap;

  const InventoryList({
    Key? key,
    required this.inventories,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: inventories.length,
        itemBuilder: (context, index) {
          final inventory = Inventory.fromJson(inventories[index]);

          return GestureDetector(
            onTap: () => onTap(inventory),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: _buildInventoryItem(inventory),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInventoryItem(Inventory inventory) {
    return Card(
      color: const Color(0xFFA30000),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                inventory.descricao ?? 'Sem descrição',
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
}
