import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/models/Supplier.dart';
import '../../routes/app_router.gr.dart';

@RoutePage()
class SupplierProductsPage extends StatefulWidget {
  final Supplier supplier;

  const SupplierProductsPage({Key? key, required this.supplier})
      : super(key: key);

  @override
  _SupplierProductsPageState createState() => _SupplierProductsPageState();
}

class _SupplierProductsPageState extends State<SupplierProductsPage> {
  List<Product> products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      // Mock de produtos
      List<Product> mockProducts = [
        Product(
            produtoKey: 1,
            quantidadeContada: 10.0,
            quantidadeSistema: 50.0,
            custoBruto: 1,
            custoLiquido: 1,
            custoContabil: 2),
        Product(
            produtoKey: 2,
            quantidadeContada: 20.0,
            quantidadeSistema: 50.0,
            custoBruto: 1,
            custoLiquido: 1,
            custoContabil: 2),
        Product(
            produtoKey: 3,
            quantidadeContada: 30.0,
            quantidadeSistema: 50.0,
            custoBruto: 1,
            custoLiquido: 1,
            custoContabil: 2),
      ];

      setState(() {
        products = mockProducts;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            AutoRouter.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.supplier.inventarioKey,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductsInfo(),
            const SizedBox(height: 20),
            _isLoading ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsInfo() {
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Produtos:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: products.map((product) {
                return _buildProductItem(product);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(const InventoryRoute());
      },
      child: Card(
        color: const Color(0xFFA30000),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produto ${product.produtoKey}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                'Quantidade: ${product.quantidadeContada.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
