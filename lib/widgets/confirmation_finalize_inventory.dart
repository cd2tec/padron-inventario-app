import 'package:flutter/material.dart';

class ConfirmationFinalizeInventory extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmationFinalizeInventory({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar Finalização'),
      content:
          const Text('Você tem certeza que deseja finalizar o inventário?'),
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
