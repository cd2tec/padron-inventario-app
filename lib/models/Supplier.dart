class Supplier {
  int id;
  String razaoSocial;
  String fantasia;
  String cnpj;
  String? cidade;
  String? uf;
  String? telefone;
  String? nroEmpresaBluesoft;
  bool cd;

  Supplier({
    required this.id,
    required this.razaoSocial,
    required this.fantasia,
    required this.cnpj,
    required this.cidade,
    required this.uf,
    required this.telefone,
    required this.nroEmpresaBluesoft,
    required this.cd,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      razaoSocial: json['razao_social'],
      fantasia: json['fantasia'],
      cnpj: json['cnpj'],
      cidade: json['cidade'],
      uf: json['uf'],
      telefone: json['telefone'],
      nroEmpresaBluesoft: json['nroempresabluesoft'],
      cd: json['cd'],
    );
  }

  @override
  String toString() {
    return '{id: $id, razaoSocial: $razaoSocial, fantasia: $fantasia, cnpj: $cnpj, cidade: $cidade, uf: $uf, telefone: $telefone, nroEmpresaBluesoft: $nroEmpresaBluesoft, cd: $cd}';
  }
}
