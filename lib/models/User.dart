class User {
  int id;
  String name;
  String email;
  String? password;
  String? cpf;
  bool isAdmin;
  bool ativo;
  int store_id;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.cpf,
    required this.isAdmin,
    required this.ativo,
    required this.store_id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      cpf: json['cpf'],
      isAdmin: json['isAdmin'] == 1,
      ativo: json['ativo'] == 1,
      store_id: json['store_id'],
    );
  }

  @override
  String toString() {
    return '{id: $id, name: $name, email: $email, password: $password, cpf: $cpf, isAdmin: $isAdmin, ativo: $ativo, store_id: $store_id}';
  }
}
