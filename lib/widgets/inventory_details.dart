import 'package:flutter/material.dart';

class InventoryDetails extends StatelessWidget {
  final String descricao;
  final String lojaKey;
  final String fornecedorKey;
  final String divisao;
  final String status;

  const InventoryDetails({
    Key? key,
    required this.descricao,
    required this.lojaKey,
    required this.fornecedorKey,
    required this.divisao,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFFA30000),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descrição: $descricao',
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 252, 252),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Loja: $lojaKey',
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 252, 252),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Fornecedor: $fornecedorKey',
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 252, 252),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Divisão: $divisao',
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 252, 252),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Status: $status',
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 252, 252),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
