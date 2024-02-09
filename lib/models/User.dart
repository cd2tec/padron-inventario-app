class User {
  String id;
  String name;
  String email;
  String password;
  String cpf;
  bool isAdmin;
  bool ativo;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.cpf,
    required this.isAdmin,
    required this.ativo
  });
}
