import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
        color: const Color(redColor),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$descriptionTittle $descricao',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 252, 252),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$storeTittle $lojaKey',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 252, 252),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$supplierTittle $fornecedorKey',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 252, 252),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$divisionTittle $divisao',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 252, 252),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$statusTittle: $status',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 252, 252),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
