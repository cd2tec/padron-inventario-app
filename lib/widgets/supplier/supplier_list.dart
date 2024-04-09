import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Supplier.dart';
import 'package:padron_inventario_app/routes/app_router.gr.dart';

class SupplierListWidget extends StatelessWidget {
  final List<Supplier> suppliers;

  const SupplierListWidget({
    Key? key,
    required this.suppliers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suppliers.length,
      itemBuilder: (context, index) {
        final supplier = suppliers[index];
        return InkWell(
          onTap: () {
            AutoRouter.of(context)
                .push(SupplierDetailRoute(supplier: supplier));
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(supplier.razaoSocial),
          ),
        );
      },
    );
  }
}
