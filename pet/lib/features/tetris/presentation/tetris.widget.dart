import 'package:flutter/material.dart';
import 'package:pet/features/tetris/features/game_field/features/game_controllers/presentation/game_controllers.widget.dart';
import 'package:pet/features/tetris/features/game_field/presentation/game_field.widget.dart';

class Tetris extends StatelessWidget {
  const Tetris({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(child: GameField(width: 10, height: 15)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: GameControllers(),
            ),
          ],
        ));
  }
}
