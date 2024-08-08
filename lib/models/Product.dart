class Product {
  int id;
  String? divisao;
  String productKey;
  int? quantidadeExposicao;
  int? quantidadePontoExtra;
  int? saldoDisponivel;
  int? multiplo;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    this.divisao,
    required this.productKey,
    this.quantidadeExposicao,
    this.quantidadePontoExtra,
    this.saldoDisponivel,
    this.multiplo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      divisao: json['divisao'],
      productKey: json['product_key'],
      quantidadeExposicao: json['quantidade_exposicao'],
      quantidadePontoExtra: json['quantidade_ponto_extra'],
      saldoDisponivel: json['saldo_disponivel'],
      multiplo: json['multiplo'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'divisao': divisao,
      'product_key': productKey,
      'quantidade_exposicao': quantidadeExposicao,
      'quantidade_ponto_extra': quantidadePontoExtra,
      'saldo_disponivel': saldoDisponivel,
      'multiplo': multiplo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
