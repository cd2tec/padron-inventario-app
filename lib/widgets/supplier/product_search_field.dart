import 'package:flutter/material.dart';

class ProductSearchField extends StatelessWidget {
  final TextEditingController productKeyController;
  final TextEditingController barcodeController;
  final Future<void> Function() onScan;
  final void Function(String) onSubmit;

  const ProductSearchField({
    Key? key,
    required this.productKeyController,
    required this.barcodeController,
    required this.onScan,
    required this.onSubmit,
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
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Código do Produto',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: onScan,
                      ),
                    ],
                  ),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                onSubmitted: onSubmit,
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
