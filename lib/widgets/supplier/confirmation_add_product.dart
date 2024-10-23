import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';

class ConfirmationAddProductInventory extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationAddProductInventory({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(addProductToInventory),
      content: const Text(wantToAddTheProductToInventory),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Text('Cancelar'),
          onPressed: () {
            onCancel();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('Sim'),
        ),
      ],
    );
  }
}
