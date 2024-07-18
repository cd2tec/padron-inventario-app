import 'package:padron_inventario_app/models/Product.dart';

class Inventory {
  int id;
  String descricao;
  String lojaKey;
  String fornecedorKey;
  String divisao;
  String status;
  List<Product> produtos;
  DateTime createdAt;
  DateTime updatedAt;

  Inventory({
    required this.id,
    required this.descricao,
    required this.lojaKey,
    required this.fornecedorKey,
    required this.divisao,
    required this.status,
    required this.produtos,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    var productList = json['produtos'] as List;
    List<Product> productListParsed =
        productList.map((i) => Product.fromJson(i)).toList();

    return Inventory(
      id: json['id'],
      descricao: json['descricao'],
      lojaKey: json['loja_key'],
      fornecedorKey: json['fornecedor_key'],
      divisao: json['divisao'],
      status: json['status'],
      produtos: productListParsed,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'loja_key': lojaKey,
      'fornecedor_key': fornecedorKey,
      'divisao': divisao,
      'status': status,
      'produtos': produtos.map((product) => product.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
