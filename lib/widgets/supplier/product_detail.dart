import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic>? productData;
  final TextEditingController quantityController;
  final void Function(String) onSubmitQuantity;

  const ProductDetail({
    Key? key,
    this.productData,
    required this.quantityController,
    required this.onSubmitQuantity,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late FocusNode _quantityFocusNode;

  @override
  void initState() {
    super.initState();
    _quantityFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _quantityFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productData == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            color: const Color(redColor),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$descriptionTittle ${widget.productData!['descricao'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Código do Produto: ${widget.productData!['produtoKey'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Loja (Bluesoft): ${widget.productData!['lojaKey'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'GTIN: ${widget.productData!['gtinPrincipal'] ?? 'N/A'}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 252, 252),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: widget.quantityController,
            focusNode: _quantityFocusNode,
            keyboardType: TextInputType.number,
            onSubmitted: widget.onSubmitQuantity,
            decoration: const InputDecoration(
              labelText: 'Quantidade',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
