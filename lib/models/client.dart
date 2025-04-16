// models/client.dart
class Client {
  int id;
  String nome;
  String tipo;
  String cpfCnpj;
  String? email;
  String? telefone;
  String? cep;
  String? endereco;
  String? bairro;
  String? cidade;
  String? uf;

  Client({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.cpfCnpj,
    this.email,
    this.telefone,
    this.cep,
    this.endereco,
    this.bairro,
    this.cidade,
    this.uf,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'tipo': tipo,
        'cpfCnpj': cpfCnpj,
        'email': email,
        'telefone': telefone,
        'cep': cep,
        'endereco': endereco,
        'bairro': bairro,
        'cidade': cidade,
        'uf': uf,
      };

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json['id'],
        nome: json['nome'],
        tipo: json['tipo'],
        cpfCnpj: json['cpfCnpj'],
        email: json['email'],
        telefone: json['telefone'],
        cep: json['cep'],
        endereco: json['endereco'],
        bairro: json['bairro'],
        cidade: json['cidade'],
        uf: json['uf'],
      );
}
