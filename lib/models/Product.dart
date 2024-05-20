class Product {
  int id;
  int supplierInventoryId;
  String gtin;
  String descricao;
  String quantidade;
  String sequencia;
  String dataValidade;
  String loteProduto;
  String createdAt;
  String updatedAt;

  Product({
    required this.id,
    required this.supplierInventoryId,
    required this.gtin,
    required this.descricao,
    required this.quantidade,
    required this.sequencia,
    required this.dataValidade,
    required this.loteProduto,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      supplierInventoryId: json['supplier_inventory_id'] ?? 0,
      gtin: json['gtin'] ?? '0',
      descricao: json['descricao'] ?? '0',
      quantidade: json['quantidade'] ?? '0',
      sequencia: json['sequencia'] ?? '0',
      dataValidade: json['dataValidade'] ?? '0',
      loteProduto: json['loteProduto'] ?? '0',
      createdAt: json['created_at'] ?? '0',
      updatedAt: json['updated_at'] ?? '0',
    );
  }

  @override
  String toString() {
    return '{id: $id, supplierInventoryId: $supplierInventoryId, gtin: $gtin, descricao: $descricao, quantidade: $quantidade, sequencia: $sequencia, dataValidade: $dataValidade, loteProduto: $loteProduto, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
