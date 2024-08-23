import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          String formattedDate = inventory.createdAt != null
              ? DateFormat('dd/MM/yyyy').format(inventory.createdAt!)
              : 'Data não disponível';

          return GestureDetector(
            onTap: () => onTap(inventory),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: _buildInventoryItem(inventory, formattedDate),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInventoryItem(Inventory inventory, String formattedDate) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descrição: ${inventory.descricao ?? "Descrição não disponível"}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Loja: ${inventory.lojaKey ?? "Loja não disponível"}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Data: $formattedDate',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fornecedor: ${inventory.fornecedorKey ?? "Fornecedor não disponível"}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Divisão: ${inventory.divisao ?? "Divisão não disponível"}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.folder_open,
              color: Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }
}
