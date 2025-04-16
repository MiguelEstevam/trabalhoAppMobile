import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/user_screen.dart';
import 'screens/client_screen.dart';
import 'screens/product_screen.dart';

void main() {
  runApp(ForcaDeVendasApp());
}

class ForcaDeVendasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Força de Vendas',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/users': (context) => UserScreen(),
        '/clients': (context) => ClientScreen(),
        '/products': (context) => ProductScreen(),
      },
    );
  }
}
