import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/features/tetris/features/game_field/bloc/tetris_game_field/tetris_game_field.bloc.dart';
import 'package:game_box/features/tetris/features/game_field/bloc/tetris_game_field/tetris_game_field.events.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/occupied_collisions.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/rotation.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/rotation_collision.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/screen_collisions.helper.dart';

class GameControllers extends StatelessWidget {
  final TetrisGameFieldBloc bloc;

  const GameControllers({
    required this.bloc,
    super.key,
  });

  int get width => bloc.state.width;

  int get height => bloc.state.height;

  List<Color?> get occupiedCells => bloc.state.occupiedCells;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeBloc>().state.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            final currentShape = bloc.state.currentShape;

            if (currentShape == null) {
              return;
            }

            if (ScreenCollisionsHelper.isCollision(
              direction: DirectionEnum.left,
              coordinates: currentShape.coordinates,
              fieldWidth: width,
              fieldHeight: height,
            ) ||
                OccupiedCollisionsHelper.isLeftCollision(
                    coordinates: currentShape.coordinates, occupied: occupiedCells, fieldWidth: width)) {
              return;
            }

            bloc.add(const TetrisUpdateCurrentShapeByDirection(direction: DirectionEnum.left));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.text,
            size: 32,
          ),
        ),
        IconButton(
          onPressed: () {
            final currentShape = bloc.state.currentShape;

            if (currentShape == null) {
              return;
            }

            final rotatedShape = RotationHelper.rotateShape(shape: currentShape, fieldWidth: width);

            if (RotationCollisionHelper.canBeRotated(
              shape: rotatedShape,
              occupiedList: occupiedCells,
              oldCoordinates: currentShape.coordinates,
            )) {
              bloc.add(TetrisUpdateCurrentShape(currentShape: rotatedShape));
            }
          },
          icon: Icon(
            Icons.rotate_right,
            color: theme.text,
            size: 40,
          ),
        ),
        IconButton(
          onPressed: () {
            final currentShape = bloc.state.currentShape;

            if (currentShape == null) {
              return;
            }

            if (ScreenCollisionsHelper.isCollision(
              direction: DirectionEnum.right,
              coordinates: currentShape.coordinates,
              fieldWidth: width,
              fieldHeight: height,
            ) ||
                OccupiedCollisionsHelper.isRightCollision(
                    coordinates: currentShape.coordinates, occupied: occupiedCells, fieldWidth: width)) {
              return;
            }

            bloc.add(const TetrisUpdateCurrentShapeByDirection(direction: DirectionEnum.right));
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            color: theme.text,
            size: 32,
          ),
        ),
      ],
    );
  }
}
