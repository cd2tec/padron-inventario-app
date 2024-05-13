class Supplier {
  String inventarioKey;
  String localEstoque;
  String loteKey;

  Supplier({
    required this.inventarioKey,
    required this.localEstoque,
    required this.loteKey,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      inventarioKey: json['inventarioKey'],
      localEstoque: json['localEstoque'],
      loteKey: json['loteKey']

    );
  }

  @override
  String toString() {
    return '{inventarioKey: $inventarioKey, localEstoque: $localEstoque, loteKey: $loteKey}';
  }
}
