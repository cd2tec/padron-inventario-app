import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/add_more_items_button.dart';
import 'package:padron_inventario_app/widgets/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/product_list.dart';

@RoutePage()
class SupplierProductsListPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const SupplierProductsListPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  _SupplierProductsListPageState createState() =>
      _SupplierProductsListPageState();
}

class _SupplierProductsListPageState extends State<SupplierProductsListPage> {
  late List<Map<String, dynamic>> products;
  final SupplierService supplierService = SupplierService();

  @override
  void initState() {
    super.initState();
    products = widget.products;
  }

  void _navigateToSearchProduct(BuildContext context) async {
    await AutoRouter.of(context).push(
      const SupplierSearchProductRoute(),
    );
  }

  void _navigateToProductDetail(
      BuildContext context, Map<String, dynamic> product) {
    AutoRouter.of(context).push(
      SupplierProductDetailRoute(productData: product),
    );
  }

  void _showFinalizeConfirmationDialog(int inventoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
              child: const Text('Sim'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _finalizeInventory(inventoryId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _finalizeInventory(int inventoryId) async {
    try {
      await supplierService.fetchFinalizeInventory(inventoryId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inventário finalizado com sucesso!'),
        ),
      );

      AutoRouter.of(context).pushAndPopUntil(
        const SupplierRoute(),
        predicate: (route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao finalizar inventário: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: 'Lista de Produtos'),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddMoreItemsButton(
                  onPressed: () => _navigateToSearchProduct(context),
                ),
              ],
            ),
          ),
          const Divider(height: 10, thickness: 2),
          Expanded(
            child: ProductList(
              products: products,
              onTap: (product) => _navigateToProductDetail(context, product),
            ),
          ),
        ],
      ),
    );
  }
}
