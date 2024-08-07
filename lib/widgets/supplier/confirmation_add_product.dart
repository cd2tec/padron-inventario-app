import 'package:flutter/material.dart';

class ConfirmationAddProductInventory extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmationAddProductInventory({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Produto ao Inventário'),
      content: const Text(
          'Você tem certeza que deseja adicionar o produto ao inventário?'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: onConfirm,
          child: const Text('Sim'),
        ),
      ],
    );
  }
}
