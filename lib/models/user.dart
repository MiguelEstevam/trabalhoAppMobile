// models/user.dart
class User {
  int id;
  String nome;
  String senha;

  User({required this.id, required this.nome, required this.senha});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'senha': senha,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        nome: json['nome'],
        senha: json['senha'],
      );
}
