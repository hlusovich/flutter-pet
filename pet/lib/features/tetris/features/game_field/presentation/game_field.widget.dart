import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet/features/tetris/domain/enums/difficulties.enum.dart';
import 'package:pet/features/tetris/domain/helpers/update_frame.helper.dart';
import 'package:pet/features/tetris/features/game_field/features/cell/presentation/cell.widget.dart';
import 'package:pet/features/tetris/features/game_field/features/shape/presentation/helpers/move.helper.dart';
import 'package:pet/features/tetris/features/game_field/features/shape/presentation/helpers/shape.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';


class GameField extends StatefulWidget {
  final int width;
  final int height;

  const GameField({required this.width, required this.height, super.key});

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  int get fieldArea => widget.height * widget.width;
  List<int> coordinates = PositionHelper.getCoordinates(shape: ShapesEnum.t, fieldWidth: 10, position: 4);

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    Duration frameRate = UpdateFrameHelper.getUpdateFrameDuration(DifficultiesEnum.hard);
    updateFrame(frameRate);
  }

  void updateFrame(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        coordinates = MoveHelper.move(coordinates: coordinates, direction: DirectionEnum.down, fieldWidth: 10);
      });
    });
  }

  void isCollision({required DirectionEnum direction, required List<int> coordinates}) {



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: fieldArea,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.width),
        itemBuilder: (context, index) => Center(
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Builder(builder: (_) {
              if (coordinates.contains(index)) {
                return const Cell(
                  color: Colors.yellow,
                );
              }
              return const Cell(
                color: Colors.redAccent,
              );
            }),
          ),
        ),
      ),
    );
  }
}
