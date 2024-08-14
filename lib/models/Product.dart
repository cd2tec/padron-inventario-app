class Product {
  int id;
  String? divisao;
  String productKey;
  int? quantidadeExposicao;
  int? quantidadePontoExtra;
  String? saldoDisponivel;
  String? gtin;
  int? multiplo;
  bool? flagUpdated;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    this.divisao,
    required this.productKey,
    this.quantidadeExposicao,
    this.quantidadePontoExtra,
    this.saldoDisponivel,
    this.gtin,
    this.multiplo,
    this.flagUpdated,
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
      gtin: json['gtin'],
      multiplo: json['multiplo'],
      flagUpdated: json['flg_updated'],
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
      'gtin': gtin,
      'multiplo': multiplo,
      'flg_updated': flagUpdated,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
