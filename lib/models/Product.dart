class Product {
  int produtoKey;
  double quantidadeContada;
  double quantidadeSistema;
  double custoBruto;
  double custoLiquido;
  double custoContabil;

  Product({
    required this.produtoKey,
    required this.quantidadeContada,
    required this.quantidadeSistema,
    required this.custoBruto,
    required this.custoContabil,
    required this.custoLiquido,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      produtoKey: json['produtoKey'],
      quantidadeContada: json['quantidadeContada'],
      quantidadeSistema: json['quantidadeSistema'],
      custoBruto: json['custoBruto'],
      custoLiquido: json['custoLiquido'],
      custoContabil: json['custoContabil'],
    );
  }

  @override
  String toString() {
    return '{produtoKey: $produtoKey, quantidadeContada: $quantidadeContada, quantidadeSistema: $quantidadeSistema, custoBruto: $custoBruto, custoContabil: $custoContabil, custoLiquido: $custoLiquido }';
  }
}
