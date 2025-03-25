import 'package:flutter/material.dart';
import 'game_button.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String? userChoice;
  String? appChoice;
  int userScore = 0;
  int appScore = 0;
  int drawScore = 0; // Contador de empates
  String resultMessage = "";

  final List<String> options = ["pedra", "papel", "tesoura"];

  void playGame(String choice) {
    setState(() {
      userChoice = choice;
      appChoice = (options..shuffle()).first;

      if (userChoice == appChoice) {
        drawScore++; // Incrementa empate
        resultMessage = "Empate!";
      } else if ((userChoice == "pedra" && appChoice == "tesoura") ||
          (userChoice == "tesoura" && appChoice == "papel") ||
          (userChoice == "papel" && appChoice == "pedra")) {
        userScore++;
        resultMessage = "Você venceu!";
      } else {
        appScore++;
        resultMessage = "O app venceu!";
      }
    });
  }

  Color getBorderColor(String option) {
    if (userChoice == option && appChoice == option) {
      return Colors.orange; // Empate -> Borda Laranja
    } else if (userChoice == option && resultMessage == "Você venceu!") {
      return Colors.green; // Vitória do Usuário -> Borda Verde
    } else if (appChoice == option && resultMessage == "O app venceu!") {
      return Colors.green; // Vitória do App -> Borda Verde
    }
    return Colors.transparent; // Sem borda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jokenpô")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Placar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("Você: $userScore  -  App: $appScore  -  Empates: $drawScore", style: TextStyle(fontSize: 20)),

          SizedBox(height: 20),

          // Exibe escolha do usuário e do app com borda
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (userChoice != null)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: getBorderColor(userChoice!), width: 5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/$userChoice.png", width: 100),
                ),
              SizedBox(width: 20),
              if (appChoice != null)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: getBorderColor(appChoice!), width: 5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Image.asset("assets/$appChoice.png", width: 100),
                ),
            ],
          ),

          SizedBox(height: 20),

          Text(resultMessage, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

          SizedBox(height: 20),

          Wrap(
            spacing: 20,
            children: options.map<Widget>((option) {
              return GameButton(
                imageName: option,
                onTap: () => playGame(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
