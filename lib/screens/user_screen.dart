import 'package:flutter/material.dart';
import '../models/user.dart';
import '../controllers/user_controller.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController _controller = UserController();
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _senhaController = TextEditingController();

  int? _editingId;

  @override
  void initState() {
    super.initState();
    _controller.loadUsers().then((_) => setState(() {}));
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: _editingId ?? DateTime.now().millisecondsSinceEpoch,
        nome: _nomeController.text,
        senha: _senhaController.text,
      );

      if (_editingId == null) {
        await _controller.addUser(user);
      } else {
        await _controller.updateUser(user);
        _editingId = null;
      }

      _nomeController.clear();
      _senhaController.clear();
      await _controller.loadUsers();
      setState(() {});
    }
  }

  void _editUser(User user) {
    _nomeController.text = user.nome;
    _senhaController.text = user.senha;
    _editingId = user.id;
  }

  void _deleteUser(int id) async {
    await _controller.deleteUser(id);
    await _controller.loadUsers();
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
      appBar: AppBar(
        title: Text('Cadastro de Usuários'),
      ),
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _saveUser,
                    child: Text(_editingId == null ? 'Cadastrar' : 'Atualizar'),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.users.length,
                itemBuilder: (context, index) {
                  final user = _controller.users[index];
                  return ListTile(
                    title: Text(user.nome),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editUser(user)),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteUser(user.id)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
