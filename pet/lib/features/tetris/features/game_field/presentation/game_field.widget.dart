import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet/features/tetris/domain/enums/difficulties.enum.dart';
import 'package:pet/features/tetris/domain/helpers/update_frame.helper.dart';
import 'package:pet/features/tetris/features/game_field/features/cell/presentation/cell.widget.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/collisions.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/game_field.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/move.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/remove_line.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/shape.helper.dart';

class GameField extends StatefulWidget {
  final int width;
  final int height;

  const GameField({required this.width, required this.height, super.key});

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  int get fieldArea => widget.height * widget.width;
  static const int initialPosition = -24;
  late List<Color?> occupiedCells;
  late Timer interval;
  late List<int> coordinates;

  @override
  void initState() {
    super.initState();
    reset();
    startGame();

    for (int cellIndex = 0; cellIndex < occupiedCells.length; cellIndex++) {
      if (cellIndex > 120 && cellIndex < 125) {
        occupiedCells[cellIndex] = Colors.amber;
      }

      if (cellIndex > 128) {
        if (cellIndex == 146) {
          continue;
        }

        if (cellIndex == 136) {
          continue;
        }
        if (cellIndex == 137) {
          continue;
        }
        occupiedCells[cellIndex] = Colors.pink;
      }
    }
  }

  void startGame() {
    Duration frameRate = UpdateFrameHelper.getUpdateFrameDuration(DifficultiesEnum.hard);
    updateFrame(frameRate);
  }

  void updateFrame(Duration frameRate) {
    interval = Timer.periodic(frameRate, (timer) {
      setState(() {
        final isBottomScreenCollision = CollisionsHelper.isScreenCollision(
          direction: DirectionEnum.down,
          coordinates: coordinates,
          fieldWidth: widget.width,
          fieldHeight: widget.height,
        );

        final isOccupiedCollision = CollisionsHelper.isOccupiedCollision<Color?>(
          coordinates: coordinates,
          fieldWidth: widget.width,
          occupied: occupiedCells,
        );

        final isCollision = isBottomScreenCollision || isOccupiedCollision;

        if (isCollision) {
          final isOutOfFieldCollision = coordinates.any((coordinate) {
            return !CollisionsHelper.isInsideOfFieldCollision(
                coordinate: coordinate, maxCoordinate: occupiedCells.length);
          });

          coordinates.forEach((coordinate) {
            if (CollisionsHelper.isInsideOfFieldCollision(
                coordinate: coordinate, maxCoordinate: occupiedCells.length)) {
              occupiedCells[coordinate] = Colors.green;
            }
          });

          if (isOutOfFieldCollision) {
            gameOver();
            return;
          }

          final Map<int, bool> removeLineMap = RemoveLineHelper.getRemoveLineMap(
            occupiedCells: occupiedCells,
            fieldHeight: widget.height,
            fieldWidth: widget.width,
          );
          coordinates = createNew();
          removeLines(removeLineMap);

          return;
        }

        coordinates =
            MoveHelper.move(coordinates: coordinates, direction: DirectionEnum.down, fieldWidth: widget.width);
      });
    });
  }

  List<int> createNew() {
    return PositionHelper.getCoordinates(shape: ShapesEnum.t, fieldWidth: 10, position: initialPosition);
  }

  void gameOver() {
    reset();
  }

  void reset() {
    occupiedCells = List.filled(10 * 15, null);
    coordinates = createNew();
  }

  void removeLines(Map<int, bool> removeLineMap) {
    final List<Color?> newOccupiedCells = [];
    final Set<int> removedLines = {};

    for (int cellIndex = 0; cellIndex < occupiedCells.length; cellIndex++) {
      final mapKey = GameFieldHelper.getRow(index: cellIndex, fieldWidth: widget.width);

      if (removeLineMap[mapKey] == true) {
        newOccupiedCells.add(null);
        removedLines.add(mapKey);
        continue;
      }

      newOccupiedCells.add(occupiedCells[cellIndex]);
    }

    occupiedCells = newOccupiedCells;
    _recalculateOccupiedCells(removedLines);
  }

  void _recalculateOccupiedCells(Set<int> removedLines) {
    if (removedLines.isEmpty) {
      return;
    }

    final lowestRemovedRowIndex = removedLines.reduce(max);
    for (int cellIndex = occupiedCells.length; cellIndex > 0; cellIndex--) {
      final mapKey = GameFieldHelper.getRow(index: cellIndex, fieldWidth: widget.width);

      if (mapKey < lowestRemovedRowIndex && occupiedCells[cellIndex] != null) {
        final cellValue = occupiedCells[cellIndex];
        occupiedCells[cellIndex] = null;
        occupiedCells[cellIndex + widget.width * removedLines.length] = cellValue;
      }
    }
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

              final occupiedColor = occupiedCells[index];

              if (occupiedColor != null) {
                return Cell(
                  color: occupiedColor,
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
