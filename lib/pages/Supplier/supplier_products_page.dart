import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

@RoutePage()
class SupplierProductsPage extends StatefulWidget {
  final List<Map<String, dynamic>> inventory;

  const SupplierProductsPage({
    Key? key,
    required this.inventory,
  }) : super(key: key);

  @override
  _SupplierProductsPageState createState() => _SupplierProductsPageState();
}

class _SupplierProductsPageState extends State<SupplierProductsPage> {
  List<Map<String, dynamic>> inventory = [];
  List<String> updatedGtins = [];

  @override
  void initState() {
    super.initState();
    inventory = widget.inventory;
    _setupNavigatorListener();
  }

  @override
  void dispose() {
    _removeNavigatorListener();
    super.dispose();
  }

  void _setupNavigatorListener() {
    AutoRouter.of(context).addListener(_onRouteChanged);
  }

  void _removeNavigatorListener() {
    AutoRouter.of(context).removeListener(_onRouteChanged);
  }

  void _onRouteChanged() {
    if (AutoRouter.of(context).current.name == 'SupplierProductsRoute') {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          productsListTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(redColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: inventory.map((productData) {
                  final product = Product.fromJson(productData);
                  final isUpdated = updatedGtins.contains(product.productKey);

                  return GestureDetector(
                    onTap: () {
                      _navigateToSearchProduct(context);
                    },
                    child: _buildProductItem(product, isUpdated),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product, bool isUpdated) {
    return Card(
      color: isUpdated ? Colors.grey : const Color(redColor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                product.productKey,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSearchProduct(BuildContext context) async {
    final result = await AutoRouter.of(context).push(
      const SupplierSearchProductRoute(),
    );
  }
}
