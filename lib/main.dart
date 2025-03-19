import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int count = 0;
  int maxCount = 10;
  Color backgroundColor = Colors.white;
  List<int> history = [];
  final List<Color> colors = [
    Colors.white,
    Colors.blueGrey,
    Colors.lightGreen,
    Colors.orangeAccent,
    Colors.pinkAccent
  ];

  void restore() {
    setState(() {
      history.add(count);
      count = 0;
    });
  }

  void increment() {
    if (count < maxCount) {
      setState(() {
        count++;
      });
    } else {
      _showLimitAlert();
    }
  }

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
    }
  }

  void changeBackgroundColor() {
    setState(() {
      backgroundColor = colors[Random().nextInt(colors.length)];
    });
  }

  void _showLimitAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Limite atingido!"),
          content: Text("O contador não pode ultrapassar $maxCount."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  void updateMaxCount(String value) {
    setState(() {
      maxCount = int.tryParse(value) ?? maxCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contador')),
      body: Container(
        color: backgroundColor,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Definir limite máximo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Digite o limite máximo",
                      ),
                      onSubmitted: updateMaxCount,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "$count",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 128),
            ),
            if (count >= maxCount)
              Text(
                "Número máximo atingido!",
                style: TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Histórico: ${history[index]}", style: TextStyle(fontSize: 18)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: restore,
            child: Icon(Icons.settings_backup_restore),
          ),
          FloatingActionButton(
            onPressed: decrement,
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: changeBackgroundColor,
            child: Icon(Icons.color_lens),
          ),
          FloatingActionButton(
            onPressed: increment,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
