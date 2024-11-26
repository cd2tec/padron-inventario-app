import 'package:flutter/material.dart';
import 'package:padron_inventario_app/models/Product.dart';
import 'package:padron_inventario_app/services/SupplierService.dart';

class SupplierProductsProvider extends ChangeNotifier {
  final SupplierService supplierService = SupplierService();

  bool _isLoading = false;
  List<Map<String, dynamic>> _products = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get products => _products;
  String? get errorMessage => _errorMessage;

  Future<void> loadInventoryDetails(int inventoryId) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _setLoading(true);

      try {
        final updatedInventories =
            await supplierService.fetchSupplierInventoryById(inventoryId);

        if (updatedInventories.isNotEmpty) {
          final inventory = updatedInventories.first;
          _products =
              List<Map<String, dynamic>>.from(inventory['produtos'] ?? []);
          print(_products);
        } else {
          _products = [];
        }

        _errorMessage = null;
      } catch (error) {
        _errorMessage = error.toString();
        print(_errorMessage);
      } finally {
        _setLoading(false);
      }
    });
  }

  Future<bool> finalizeInventory(int inventoryId) async {
    final allProductsValid = _products.every((productData) {
      final product = Product.fromJson(productData);
      return product.flagUpdated == true;
    });

    if (!allProductsValid) {
      _errorMessage = "Todos os produtos precisam estar atualizados.";
      notifyListeners();
      return false;
    }

    try {
      await supplierService.fetchFinalizeInventory(inventoryId);
      _errorMessage = null;
      return true;
    } catch (error) {
      _errorMessage = error.toString();
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
