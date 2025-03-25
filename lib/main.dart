import 'package:flutter/material.dart';
import 'game_page.dart';

void main() {
  runApp(const JokenpoApp());
}

class JokenpoApp extends StatelessWidget {
  const JokenpoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokenpô',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GamePage(),
    );
  }
}
