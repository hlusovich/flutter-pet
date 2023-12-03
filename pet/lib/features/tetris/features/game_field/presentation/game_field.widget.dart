import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pet/features/tetris/domain/enums/difficulties.enum.dart';
import 'package:pet/features/tetris/domain/helpers/colors.helper.dart';
import 'package:pet/features/tetris/domain/helpers/update_frame.helper.dart';
import 'package:pet/features/tetris/features/game_field/domain/models/shape.model.dart';
import 'package:pet/features/tetris/features/game_field/features/cell/presentation/cell.widget.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/collisions.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/game_field.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/move.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/occupied_collisions.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/remove_line.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/rotation.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/rotation_collision.helper.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/screen_collisions.helper.dart';
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

  int get initialPosition => -20 - (widget.width / 2).floor() - 1;
  late List<Color?> occupiedCells;
  late Timer interval;
  late Shape currentShape;
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioPlayer themeAudioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    reset();
    runAudio();
    startGame();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    themeAudioPlayer.dispose();

    super.dispose();
  }

  Future<void> runAudio() async {
    themeAudioPlayer.setReleaseMode(ReleaseMode.loop);
    themeAudioPlayer.play(AssetSource('audio/Tetris.mp3'));
    //should be closed stream
  }

  void startGame() {
    Duration frameRate = UpdateFrameHelper.getUpdateFrameDuration(DifficultiesEnum.easy);
    updateFrame(frameRate);
  }

  void updateFrame(Duration frameRate) {
    interval = Timer.periodic(frameRate, (timer) {
      setState(() {
        final isBottomScreenCollision = ScreenCollisionsHelper.isCollision(
          direction: DirectionEnum.down,
          coordinates: currentShape.coordinates,
          fieldWidth: widget.width,
          fieldHeight: widget.height,
        );

        final isOccupiedCollision = OccupiedCollisionsHelper.isDownCollision<Color?>(
          coordinates: currentShape.coordinates,
          fieldWidth: widget.width,
          occupied: occupiedCells,
        );

        final isCollision = isBottomScreenCollision || isOccupiedCollision;

        if (isCollision) {
          final isOutOfFieldCollision = currentShape.coordinates.any((coordinate) {
            return !CollisionsHelper.isInsideOfField(coordinate: coordinate, maxCoordinate: occupiedCells.length);
          });

          currentShape.coordinates.forEach((coordinate) {
            if (CollisionsHelper.isInsideOfField(coordinate: coordinate, maxCoordinate: occupiedCells.length)) {
              occupiedCells[coordinate] = currentShape.color;
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
          currentShape = createNew();
          removeLines(removeLineMap);

          return;
        }

        currentShape = updatePositionByDirection(shape: currentShape, direction: DirectionEnum.down);
      });
    });
  }

  Shape createNew() {
    // final shape = ShapesHelper.getRandomShapeType();
    final shape = ShapesEnum.i;

    return Shape(
        color: ColorsHelper.getRandomColor(),
        type: shape,
        coordinates: PositionHelper.getCoordinates(shape: shape, fieldWidth: widget.width, position: initialPosition));
  }

  Shape updatePositionByDirection({
    required Shape shape,
    required DirectionEnum direction,
  }) {
    return shape.copyWith(
      coordinates: MoveHelper.move(
        coordinates: shape.coordinates,
        direction: direction,
        fieldWidth: widget.width,
      ),
    );
  }

  void gameOver() {
    reset();
  }

  void reset() {
    occupiedCells = List.filled(10 * 15, null);
    currentShape = createNew();
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

    if (removedLines.isEmpty) {
      return;
    }

    themeAudioPlayer.pause();
    audioPlayer.play(AssetSource('audio/stage_clear.mp3')).then((value) => themeAudioPlayer.resume());
    _recalculateOccupiedCells(removedLines);
  }

  void _recalculateOccupiedCells(Set<int> removedLines) {
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
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: fieldArea,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.width),
            itemBuilder: (context, index) => Center(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Builder(builder: (_) {
                  if (currentShape.coordinates.contains(index)) {
                    return Cell(
                      color: currentShape.color,
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (ScreenCollisionsHelper.isCollision(
                      direction: DirectionEnum.left,
                      coordinates: currentShape.coordinates,
                      fieldWidth: widget.width,
                      fieldHeight: widget.height,
                    ) ||
                    OccupiedCollisionsHelper.isLeftCollision(
                        coordinates: currentShape.coordinates, occupied: occupiedCells, fieldWidth: widget.width)) {
                  return;
                }
                currentShape = updatePositionByDirection(shape: currentShape, direction: DirectionEnum.left);
                setState(() {});
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: () {
                final rotatedShape = RotationHelper.rotateShape(shape: currentShape, fieldWidth: widget.width);

                if (RotationCollisionHelper.canBeRotated(
                  shape: rotatedShape,
                  occupiedList: occupiedCells,
                  oldCoordinates: currentShape.coordinates,
                )) {
                  setState(() {
                    currentShape = rotatedShape;
                  });
                }
              },
              icon: const Icon(
                Icons.rotate_right,
                size: 40,
              ),
            ),
            IconButton(
              onPressed: () {
                if (ScreenCollisionsHelper.isCollision(
                      direction: DirectionEnum.right,
                      coordinates: currentShape.coordinates,
                      fieldWidth: widget.width,
                      fieldHeight: widget.height,
                    ) ||
                    OccupiedCollisionsHelper.isRightCollision(
                        coordinates: currentShape.coordinates, occupied: occupiedCells, fieldWidth: widget.width)) {
                  return;
                }

                currentShape = updatePositionByDirection(shape: currentShape, direction: DirectionEnum.right);
                setState(() {});
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
