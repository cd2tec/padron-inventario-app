class Product {
  int id;
  int inventoryId;
  String productKey;
  String gtin;
  String descricao;
  int quantidadeExposicao;
  int quantidadePontoExtra;
  String saldoDisponivel;
  int multiplo;
  String coletado;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.inventoryId,
    required this.productKey,
    required this.gtin,
    required this.descricao,
    required this.quantidadeExposicao,
    required this.quantidadePontoExtra,
    required this.saldoDisponivel,
    required this.multiplo,
    required this.coletado,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      inventoryId: json['inventory_id'],
      productKey: json['product_key'],
      gtin: json['gtin'],
      descricao: json['descricao'],
      quantidadeExposicao: json['quantidade_exposicao'],
      quantidadePontoExtra: json['quantidade_ponto_extra'],
      saldoDisponivel: json['saldo_disponivel'],
      multiplo: json['multiplo'],
      coletado: json['coletado'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inventory_id': inventoryId,
      'product_key': productKey,
      'gtin': gtin,
      'descricao': descricao,
      'quantidade_exposicao': quantidadeExposicao,
      'quantidade_ponto_extra': quantidadePontoExtra,
      'saldo_disponivel': saldoDisponivel,
      'multiplo': multiplo,
      'coletado': coletado,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
