import 'package:flutter/material.dart';

class ProductSearchField extends StatefulWidget {
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
  _ProductSearchFieldState createState() => _ProductSearchFieldState();
}

class _ProductSearchFieldState extends State<ProductSearchField> {
  late FocusNode _productKeyFocusNode;

  @override
  void initState() {
    super.initState();
    _productKeyFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productKeyFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _productKeyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.productKeyController,
                focusNode: _productKeyFocusNode,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Código do Produto',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: widget.onScan,
                      ),
                    ],
                  ),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.center,
                onSubmitted: widget.onSubmit,
              ),
            ),
          ],
        ),
        Visibility(
          visible: widget.barcodeController.text.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Text(
                "Código de barras: ${widget.barcodeController.text}",
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
