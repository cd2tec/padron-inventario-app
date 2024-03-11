class Store {
  int id;
  String razaoSocial;
  String fantasia;
  String cnpj;
  String? cidade;
  String? uf;
  String? telefone;
  String? nroEmpresaProteus;
  String? nroEmpresaBluesoft;
  bool cd;

  Store({
    required this.id,
    required this.razaoSocial,
    required this.fantasia,
    required this.cnpj,
    required this.cidade,
    required this.uf,
    required this.telefone,
    required this.nroEmpresaProteus,
    required this.nroEmpresaBluesoft,
    required this.cd,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      razaoSocial: json['razao_social'],
      fantasia: json['fantasia'],
      cnpj: json['cnpj'],
      cidade: json['cidade'],
      uf: json['uf'],
      telefone: json['telefone'],
      nroEmpresaProteus: json['nroempresaproteus'],
      nroEmpresaBluesoft: json['nroempresabluesoft'],
      cd: json['cd'],
    );
  }

  @override
  String toString() {
    return '{id: $id, razaoSocial: $razaoSocial, fantasia: $fantasia, cnpj: $cnpj, cidade: $cidade, uf: $uf, telefone: $telefone, nroEmpresaProteus: $nroEmpresaProteus, nroEmpresaBluesoft: $nroEmpresaBluesoft, cd: $cd}';
  }
}
