import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String imageName;
  final VoidCallback onTap;

  const GameButton({super.key, required this.imageName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Image.asset("assets/$imageName.png", width: 70, height: 70),
      ),
    );
  }
}
