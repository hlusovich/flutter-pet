import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet/features/game_field/features/cell/presentation/cell.widget.dart';

class GameField extends StatefulWidget {
  final int width;
  final int height;

  const GameField({required this.width, required this.height, super.key});

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  int get fieldArea => widget.height * widget.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: fieldArea,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.width),
        itemBuilder: (context, index) => const Center(
          child: Padding(
            padding: EdgeInsets.all(1),
            child: Cell(
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
