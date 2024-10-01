import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/constants/constants.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';
import 'package:padron_inventario_app/widgets/supplier/app_bar_title.dart';
import 'package:padron_inventario_app/widgets/supplier/confirmation_finalize_inventory.dart';
import 'package:padron_inventario_app/widgets/supplier/finalize_button.dart';
import 'package:padron_inventario_app/widgets/supplier/product_list.dart';

@RoutePage()
class SupplierProductsListPage extends StatefulWidget {
  final Map<String, dynamic> inventory;
  final List<Map<String, dynamic>> products;

  const SupplierProductsListPage({
    Key? key,
    required this.inventory,
    required this.products,
  }) : super(key: key);

  @override
  _SupplierProductsListPageState createState() =>
      _SupplierProductsListPageState();
}

class _SupplierProductsListPageState extends State<SupplierProductsListPage>
    with RouteAware {
  final SupplierService supplierService = SupplierService();
  bool isLoading = false;
  late List<Map<String, dynamic>> products;

  @override
  void initState() {
    super.initState();
    _loadInventoryDetails();
    products = widget.products;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AutoRouter.of(context).addListener(_onRouteChanged);
  }

  @override
  void dispose() {
    AutoRouter.of(context).removeListener(_onRouteChanged);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadInventoryDetails();
  }

  Future<void> _loadInventoryDetails() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      final List<Map<String, dynamic>> updatedInventories =
          await supplierService
              .fetchSupplierInventoryById(widget.inventory['id']);

      if (updatedInventories.isNotEmpty) {
        final Map<String, dynamic> inventory = updatedInventories.first;
        if (mounted) {
          setState(() {
            products =
                List<Map<String, dynamic>>.from(inventory['produtos'] ?? []);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            products = [];
          });
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$errorLoadingInventoryDetails $error'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _onRouteChanged() {
    _loadInventoryDetails();
  }

  void _navigateToSearchProduct(BuildContext context) async {
    await AutoRouter.of(context).push(
      const SupplierSearchProductRoute(),
    );
  }

  void _navigateToProductDetail(
      BuildContext context, Map<String, dynamic> product) {
    AutoRouter.of(context).push(
      SupplierProductDetailRoute(
        productData: product,
        additionalData: {
          'inventoryId': widget.inventory['id'],
          'products': products,
        },
      ),
    );
  }

  void _showFinalizeConfirmationDialog(int inventoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationFinalizeInventory(
          onConfirm: () async {
            await _finalizeInventory(inventoryId);
          },
        );
      },
    );
  }

  Future<void> _finalizeInventory(int inventoryId) async {
    bool allProductsValid = true;
    for (var productData in products) {
      final product = Product.fromJson(productData);
      if (product.flagUpdated == false) {
        allProductsValid = false;
        break;
      }
    }

    if (!allProductsValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(allProductsNeedToBeUpdated),
        ),
      );
      return;
    }

    try {
      await supplierService.fetchFinalizeInventory(inventoryId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(inventoryCompletedSuccessfully),
        ),
      );

      isLoading = true;
      AutoRouter.of(context).replace(const SupplierRoute());
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$errorCompletingInventory $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    products.sort((a, b) {
      final productA = Product.fromJson(a);
      final productB = Product.fromJson(b);

      final flgUpdatedA = productA.flagUpdated ?? true;
      final flgUpdatedB = productB.flagUpdated ?? true;

      if (!flgUpdatedA && flgUpdatedB) {
        return -1;
      } else if (flgUpdatedA && !flgUpdatedB) {
        return 1;
      } else {
        final descriptionA = productA.descricao?.toLowerCase() ?? '';
        final descriptionB = productB.descricao?.toLowerCase() ?? '';
        return descriptionA.compareTo(descriptionB);
      }
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const AppBarTitle(title: productsListTitle),
        backgroundColor: const Color(redColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final productData = products[index];
                final product = Product.fromJson(productData);

                return Container(
                  color: product.flagUpdated == false
                      ? Colors.red[100]
                      : Colors.transparent,
                  child: ProductList(
                    products: [productData],
                    onTap: (product) =>
                        _navigateToProductDetail(context, productData),
                  ),
                );
              },
            ),
          ),
          FinalizeButton(
            onPressed: () {
              _showFinalizeConfirmationDialog(widget.inventory['id']);
            },
          ),
        ],
      ),
    );
  }
}
