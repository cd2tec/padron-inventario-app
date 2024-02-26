class Store {
  String id;
  String razao_social;
  String fantasia;
  String cnpj;
  String cidade;
  String uf;
  String telefone;
  String nroempresaproteus;
  String nroempresabluesoft;
  bool cd;

  Store({
    required this.id,
    required this.razao_social,
    required this.fantasia,
    required this.cnpj,
    required this.cidade,
    required this.uf,
    required this.telefone,
    required this.nroempresaproteus,
    required this.nroempresabluesoft,
    required this.cd,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'].toString(),
      razao_social: json['razao_social'].toString(),
      fantasia: json['fantasia'].toString(),
      cnpj: json['cnpj'].toString(),
      cidade: json['cidade'].toString(),
      uf: json['uf'].toString(),
      telefone: json['telefone'].toString(),
      nroempresaproteus: json['nroempresaproteus'].toString(),
      nroempresabluesoft: json['nroempresabluesoft'].toString(),
      cd: json['cd'] as bool,
    );
  }
}
