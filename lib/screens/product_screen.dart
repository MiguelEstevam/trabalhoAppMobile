// screens/product_screen.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController _controller = ProductController();
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _unidadeController = TextEditingController();
  final _qtdEstoqueController = TextEditingController();
  final _precoVendaController = TextEditingController();
  final _statusController = TextEditingController();
  final _custoController = TextEditingController();
  final _codigoBarraController = TextEditingController();

  int? _editingId;

  @override
  void initState() {
    super.initState();
    _controller.loadProducts().then((_) => setState(() {}));
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: _editingId ?? DateTime.now().millisecondsSinceEpoch,
        nome: _nomeController.text,
        unidade: _unidadeController.text,
        qtdEstoque: int.parse(_qtdEstoqueController.text),
        precoVenda: double.parse(_precoVendaController.text),
        status: int.parse(_statusController.text),
        custo: _custoController.text.isNotEmpty ? double.parse(_custoController.text) : null,
        codigoBarra: _codigoBarraController.text,
      );

      if (_editingId == null) {
        await _controller.addProduct(product);
      } else {
        await _controller.updateProduct(product);
        _editingId = null;
      }

      _nomeController.clear();
      _unidadeController.clear();
      _qtdEstoqueController.clear();
      _precoVendaController.clear();
      _statusController.clear();
      _custoController.clear();
      _codigoBarraController.clear();

      await _controller.loadProducts();
      setState(() {});
    }
  }

  void _editProduct(Product product) {
    _nomeController.text = product.nome;
    _unidadeController.text = product.unidade;
    _qtdEstoqueController.text = product.qtdEstoque.toString();
    _precoVendaController.text = product.precoVenda.toString();
    _statusController.text = product.status.toString();
    _custoController.text = product.custo?.toString() ?? '';
    _codigoBarraController.text = product.codigoBarra ?? '';
    _editingId = product.id;
  }

  void _deleteProduct(int id) async {
    await _controller.deleteProduct(id);
    await _controller.loadProducts();
    setState(() {});
  }

  void _navigate(String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Produtos')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
            ListTile(
              title: Text('Usuários'),
              onTap: () => _navigate('/users'),
            ),
            ListTile(
              title: Text('Clientes'),
              onTap: () => _navigate('/clients'),
            ),
            ListTile(
              title: Text('Produtos'),
              onTap: () => _navigate('/products'),
            ),
            Divider(),
            ListTile(
              title: Text('Sair'),
              leading: Icon(Icons.logout),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(controller: _nomeController, decoration: InputDecoration(labelText: 'Nome'), validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                  TextFormField(controller: _unidadeController, decoration: InputDecoration(labelText: 'Unidade (un, cx, kg, lt, ml)'), validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                  TextFormField(controller: _qtdEstoqueController, decoration: InputDecoration(labelText: 'Qtd. Estoque'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                  TextFormField(controller: _precoVendaController, decoration: InputDecoration(labelText: 'Preço de Venda'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                  TextFormField(controller: _statusController, decoration: InputDecoration(labelText: 'Status (0 - Ativo / 1 - Inativo)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                  TextFormField(controller: _custoController, decoration: InputDecoration(labelText: 'Custo'), keyboardType: TextInputType.number),
                  TextFormField(controller: _codigoBarraController, decoration: InputDecoration(labelText: 'Código de Barras')),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _saveProduct, child: Text(_editingId == null ? 'Cadastrar' : 'Atualizar')),
                ],
              ),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _controller.products.length,
              itemBuilder: (context, index) {
                final product = _controller.products[index];
                return ListTile(
                  title: Text(product.nome),
                  subtitle: Text('R\$ ${product.precoVenda.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editProduct(product)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteProduct(product.id)),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
