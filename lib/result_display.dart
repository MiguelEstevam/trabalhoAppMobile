import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String? choice;
  final bool isWinner;

  const ResultDisplay({super.key, required this.choice, required this.isWinner});

  @override
  Widget build(BuildContext context) {
    if (choice == null) {
      return Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: const Text("?", style: TextStyle(fontSize: 40)),
      );
    }

    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isWinner ? Colors.green : Colors.grey,
          width: 4,
        ),
      ),
      child: Image.asset("assets/$choice.png", width: 80, height: 80),
    );
  }
}
