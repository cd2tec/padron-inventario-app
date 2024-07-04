import 'package:flutter/material.dart';

class AddMoreItemsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddMoreItemsButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 211, 41, 29),
            shape: const CircleBorder(),
            minimumSize: const Size(35, 35),
          ),
          onPressed: onPressed,
          child: const Icon(Icons.add, size: 20),
        ),
        const Text(
          'Adicionar mais itens',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ],
    );
  }
}
