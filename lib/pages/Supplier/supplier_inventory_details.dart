import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:padron_inventario_app/models/Inventory.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/confirmation_finalize_inventory.dart';
import 'package:padron_inventario_app/widgets/finalize_button.dart';
import 'package:padron_inventario_app/widgets/inventory_details.dart';
import 'package:padron_inventario_app/widgets/product_list_button.dart';
import 'package:padron_inventario_app/widgets/total_products.dart';

@RoutePage()
class SupplierInventoryDetailsPage extends StatefulWidget {
  final Map<String, dynamic> inventory;

  const SupplierInventoryDetailsPage({
    Key? key,
    required this.inventory,
  }) : super(key: key);

  @override
  _SupplierInventoryDetailsPageState createState() =>
      _SupplierInventoryDetailsPageState();
}

class _SupplierInventoryDetailsPageState
    extends State<SupplierInventoryDetailsPage> {
  late List<Map<String, dynamic>> products;
  final SupplierService supplierService = SupplierService();

  @override
  void initState() {
    super.initState();
    products = widget.inventory['produtos'] ?? [];
  }

  void _showFinalizeConfirmationDialog(int inventoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationFinalizeInventory(
          onConfirm: () async {
            Navigator.of(context).pop();
            await _finalizeInventory(inventoryId);
          },
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
    final inventory = Inventory.fromJson(widget.inventory);
    int totalProducts = inventory.produtos.length;
    int collectedProducts =
        inventory.produtos.where((product) => product.coletado == 'Sim').length;
    int notCollectedProducts = totalProducts - collectedProducts;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: AppBarTitle(title: inventory.descricao),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Detalhes do Inventário',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Divider(height: 10, thickness: 2),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InventoryDetails(
                    descricao: inventory.descricao,
                    lojaKey: inventory.lojaKey,
                    fornecedorKey: inventory.fornecedorKey,
                    divisao: inventory.divisao,
                    status: inventory.status,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TotalProducts(
                    totalProducts: totalProducts,
                    collectedProducts: collectedProducts,
                    notCollectedProducts: notCollectedProducts,
                  ),
                ),
                const Divider(height: 10, thickness: 2),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ProductListButton(
                    products: products,
                  ),
                ),
                const SizedBox(
                    height: 60), // Espaço para o botão FinalizeButton
              ],
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: FinalizeButton(
              onPressed: () => _showFinalizeConfirmationDialog(inventory.id),
            ),
          )),
        ],
      ),
    );
  }
}
