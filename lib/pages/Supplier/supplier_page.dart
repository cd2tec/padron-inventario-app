import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/models/Inventory.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/services/UserService.dart';
import 'package:padron_inventario_app/widgets/supplier/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/supplier/inventory_list.dart';
import 'package:padron_inventario_app/widgets/supplier/loader_overlay.dart';

import '../../widgets/notifications/snackbar_widgets.dart';

@RoutePage()
class SupplierPage extends StatefulWidget {
  const SupplierPage({Key? key}) : super(key: key);

  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  SupplierService supplierService = SupplierService();
  UserService userService = UserService();

  bool isLoading = false;
  List<Map<String, dynamic>> inventories = [];

  @override
  void initState() {
    super.initState();
    _fetchInventoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: supplierByInventoryTitle),
        backgroundColor: const Color(redColor),
      ),
      body: LoaderOverlay(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InventoryList(
              inventories: inventories,
              onTap: (inventory) =>
                  _navigateToInventoryDetails(context, inventory),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToInventoryDetails(
      BuildContext context, Inventory inventory) async {
    await AutoRouter.of(context).push(
      SupplierInventoryDetailsRoute(inventory: inventory.toJson()),
    );

    if (mounted) {
      _fetchInventoriesList();
    }
  }

  Future<void> _fetchInventoriesList() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Map<String, dynamic>> fetchedInventories =
          await supplierService.fetchSupplierInventoriesList();

      setState(() {
        inventories = fetchedInventories;
      });
    } catch (error) {
      if (error is http.ClientException) {
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(message: formatMessage(error.message)),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatMessage(String message) {
    Map<String, dynamic> decodedResponse = jsonDecode(message);
    return decodedResponse['message'];
  }
}
