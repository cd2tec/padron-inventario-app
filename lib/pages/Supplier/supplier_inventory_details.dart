import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Inventory.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/confirm_button.dart';
import 'package:padron_inventario_app/widgets/confirmation_finalize_inventory.dart';
import 'package:padron_inventario_app/widgets/inventory_details.dart';
import 'package:padron_inventario_app/widgets/items_list_button.dart';

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
        title: AppBarTitle(title: 'Detalhes do ${inventory.descricao}'),
        backgroundColor: const Color(0xFFA30000),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                const Divider(height: 10, thickness: 2),
                const SizedBox(height: 60),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ConfirmButton(
                        onPressed: () =>
                            _showFinalizeConfirmationDialog(inventory.id),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ItemsListButton(
                    products: products,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
