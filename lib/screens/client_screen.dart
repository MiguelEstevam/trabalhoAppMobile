import 'package:flutter/material.dart';
import '../models/client.dart';
import '../controllers/client_controller.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final ClientController _controller = ClientController();
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _tipoController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ufController = TextEditingController();

  int? _editingId;

  @override
  void initState() {
    super.initState();
    _controller.loadClients().then((_) => setState(() {}));
  }

  void _saveClient() async {
    if (_formKey.currentState!.validate()) {
      final client = Client(
        id: _editingId ?? DateTime.now().millisecondsSinceEpoch,
        nome: _nomeController.text,
        tipo: _tipoController.text,
        cpfCnpj: _cpfCnpjController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        cep: _cepController.text,
        endereco: _enderecoController.text,
        bairro: _bairroController.text,
        cidade: _cidadeController.text,
        uf: _ufController.text,
      );

      if (_editingId == null) {
        await _controller.addClient(client);
      } else {
        await _controller.updateClient(client);
        _editingId = null;
      }

      _nomeController.clear();
      _tipoController.clear();
      _cpfCnpjController.clear();
      _emailController.clear();
      _telefoneController.clear();
      _cepController.clear();
      _enderecoController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _ufController.clear();

      await _controller.loadClients();
      setState(() {});
    }
  }

  void _editClient(Client client) {
    _nomeController.text = client.nome;
    _tipoController.text = client.tipo;
    _cpfCnpjController.text = client.cpfCnpj;
    _emailController.text = client.email ?? '';
    _telefoneController.text = client.telefone ?? '';
    _cepController.text = client.cep ?? '';
    _enderecoController.text = client.endereco ?? '';
    _bairroController.text = client.bairro ?? '';
    _cidadeController.text = client.cidade ?? '';
    _ufController.text = client.uf ?? '';
    _editingId = client.id;
  }

  void _deleteClient(int id) async {
    await _controller.deleteClient(id);
    await _controller.loadClients();
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
      appBar: AppBar(title: Text('Cadastro de Clientes')),
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
                  TextFormField(controller: _tipoController, decoration: InputDecoration(labelText: 'Tipo (F ou J)'), validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                  TextFormField(controller: _cpfCnpjController, decoration: InputDecoration(labelText: 'CPF/CNPJ'), validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                  TextFormField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
                  TextFormField(controller: _telefoneController, decoration: InputDecoration(labelText: 'Telefone')),
                  TextFormField(controller: _cepController, decoration: InputDecoration(labelText: 'CEP')),
                  TextFormField(controller: _enderecoController, decoration: InputDecoration(labelText: 'Endereço')),
                  TextFormField(controller: _bairroController, decoration: InputDecoration(labelText: 'Bairro')),
                  TextFormField(controller: _cidadeController, decoration: InputDecoration(labelText: 'Cidade')),
                  TextFormField(controller: _ufController, decoration: InputDecoration(labelText: 'UF')),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _saveClient, child: Text(_editingId == null ? 'Cadastrar' : 'Atualizar')),
                ],
              ),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _controller.clients.length,
              itemBuilder: (context, index) {
                final client = _controller.clients[index];
                return ListTile(
                  title: Text(client.nome),
                  subtitle: Text(client.cpfCnpj),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editClient(client)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteClient(client.id)),
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
