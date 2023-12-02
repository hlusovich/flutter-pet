import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameField extends StatefulWidget {
  final int wide;
  final int height;

  const GameField({required this.wide, required this.height ,super.key});

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.wide),
        itemBuilder: (context, index) => Center(
          child: Text(
            index.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
