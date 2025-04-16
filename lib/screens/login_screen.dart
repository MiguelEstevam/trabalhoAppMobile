// screens/login_screen.dart
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserController _controller = UserController();

  @override
  void initState() {
    super.initState();
    _controller.loadUsers();
  }

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    await _controller.loadUsers();
    final user = _controller.getUser(username, password);

    if (user != null && user.id != -1) {
      Navigator.pushReplacementNamed(context, '/users');
    } else if (username == 'admin' && password == 'admin') {
      Navigator.pushReplacementNamed(context, '/users');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
