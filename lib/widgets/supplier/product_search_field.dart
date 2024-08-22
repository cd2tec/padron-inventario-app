import 'package:flutter/material.dart';

class ProductSearchField extends StatelessWidget {
  final TextEditingController productKeyController;
  final TextEditingController barcodeController;

  const ProductSearchField({
    Key? key,
    required this.productKeyController,
    required this.barcodeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: productKeyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Código do Produto',
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Visibility(
          visible: barcodeController.text.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Text(
                "Código de barras: ${barcodeController.text}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
