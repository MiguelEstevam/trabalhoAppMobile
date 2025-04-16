// models/product.dart
class Product {
  int id;
  String nome;
  String unidade;
  int qtdEstoque;
  double precoVenda;
  int status;
  double? custo;
  String? codigoBarra;

  Product({
    required this.id,
    required this.nome,
    required this.unidade,
    required this.qtdEstoque,
    required this.precoVenda,
    required this.status,
    this.custo,
    this.codigoBarra,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'unidade': unidade,
        'qtdEstoque': qtdEstoque,
        'precoVenda': precoVenda,
        'status': status,
        'custo': custo,
        'codigoBarra': codigoBarra,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        nome: json['nome'],
        unidade: json['unidade'],
        qtdEstoque: json['qtdEstoque'],
        precoVenda: json['precoVenda'],
        status: json['status'],
        custo: json['custo'],
        codigoBarra: json['codigoBarra'],
      );
}
