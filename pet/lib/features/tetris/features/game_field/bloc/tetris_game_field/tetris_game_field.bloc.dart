import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/features/tetris/domain/enums/difficulties.enum.dart';
import 'package:game_box/features/tetris/domain/helpers/colors.helper.dart';
import 'package:game_box/features/tetris/domain/helpers/shapes.helper.dart';
import 'package:game_box/features/tetris/domain/helpers/update_frame.helper.dart';
import 'package:game_box/features/tetris/features/game_field/bloc/tetris_game_field/tetris_game_field.events.dart';
import 'package:game_box/features/tetris/features/game_field/bloc/tetris_game_field/tetris_game_field.state.dart';
import 'package:game_box/features/tetris/features/game_field/domain/enums/common.constants.dart';
import 'package:game_box/features/tetris/features/game_field/domain/models/shape.model.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/collisions.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/game_field.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/move.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/occupied_collisions.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/remove_line.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/screen_collisions.helper.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/shape.helper.dart';

class TetrisGameFieldBloc extends Bloc<TetrisGameFieldEvents, TetrisGameFieldState> {
  static const int _initialHeight = -20;

  TetrisGameFieldBloc()
      : super(TetrisGameFieldState(occupiedCells: baseField, width: baseFieldWidth, height: baseFieldHeight)) {
    on<UpdateGameFieldSize>(_onUpdateGameFieldSize);
    on<TetrisStartFrameUpdate>(_onStartTetrisFrameUpdate);
    on<TetrisResetField>(_onTetrisResetField);
    on<TetrisUpdateOccupiedFields>(_onTetrisUpdateOccupiedFields);
    on<TetrisAddNewShape>(_onTetrisAddNewShape);
    on<TetrisUpdateCurrentShape>(_onTetrisTetrisUpdateCurrentShape);
    on<TetrisUpdateCurrentShapeByDirection>(_onTetrisTetrisUpdateCurrentShapeByDirection);
  }

  late final Timer interval;

  int get initialPosition => _initialHeight - (state.width / 2).floor() - 1;

  void _onUpdateGameFieldSize(UpdateGameFieldSize event, Emitter<TetrisGameFieldState> emit) async {
    emit(state.copyWith(width: event.width, height: event.height));
  }

  void _onTetrisTetrisUpdateCurrentShape(TetrisUpdateCurrentShape event, Emitter<TetrisGameFieldState> emit) async {
    emit(state.copyWith(
      currentShape: event.currentShape,
    ));
  }

  void _onTetrisTetrisUpdateCurrentShapeByDirection(
      TetrisUpdateCurrentShapeByDirection event, Emitter<TetrisGameFieldState> emit) async {
    final currentShape = state.currentShape;

    if (currentShape == null) {
      return;
    }

    emit(state.copyWith(
      currentShape: updatePositionByDirection(shape: currentShape, direction: event.direction),
    ));
  }

  void _onStartTetrisFrameUpdate(TetrisStartFrameUpdate event, Emitter<TetrisGameFieldState> emit) async {
    Duration frameRate = UpdateFrameHelper.getUpdateFrameDuration(DifficultiesEnum.easy);
    updateFrame(frameRate);
  }

  void _onTetrisResetField(TetrisResetField event, Emitter<TetrisGameFieldState> emit) async {
    _reset();
  }

  void _onTetrisAddNewShape(TetrisAddNewShape event, Emitter<TetrisGameFieldState> emit) async {
    emit(state.copyWith(
      currentShape: _createNew(),
      occupiedCells: event.occupiedCells,
    ));
  }

  void _onTetrisUpdateOccupiedFields(TetrisUpdateOccupiedFields event, Emitter<TetrisGameFieldState> emit) async {
    emit(state.copyWith(
      occupiedCells: event.occupiedCells,
    ));
  }

  void updateFrame(Duration frameRate) {
    interval = Timer.periodic(frameRate, (timer) {
      final currentShape = state.currentShape;

      if (currentShape == null) {
        return;
      }

      final occupiedCells = [...state.occupiedCells];

      if (_isUpdateScreenCollisions(occupiedCells: occupiedCells, coordinates: currentShape.coordinates)) {
        final isOutOfFieldCollision = _isGameOver(occupiedCells: occupiedCells, coordinates: currentShape.coordinates);

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
          fieldHeight: state.height,
          fieldWidth: state.width,
        );

        _addNewShape(occupiedCells: occupiedCells, removeLineMap: removeLineMap);

        return;
      }

      add(TetrisUpdateCurrentShape(
          currentShape: updatePositionByDirection(shape: currentShape, direction: DirectionEnum.down)));
    });
  }

  Shape updatePositionByDirection({
    required Shape shape,
    required DirectionEnum direction,
  }) {
    return shape.copyWith(
      coordinates: MoveHelper.move(
        coordinates: shape.coordinates,
        direction: direction,
        fieldWidth: state.width,
      ),
    );
  }

  void gameOver() {
    _reset();
  }

  void _reset() {
    final occupiedCells = List.filled(state.width * state.height, null);
    add(TetrisAddNewShape(occupiedCells: occupiedCells));
  }

  List<Color?> _removeLines({required Map<int, bool> removeLineMap, required List<Color?> occupiedCells}) {
    final List<Color?> newOccupiedCells = [];
    final Set<int> removedLines = {};

    for (int cellIndex = 0; cellIndex < occupiedCells.length; cellIndex++) {
      final mapKey = GameFieldHelper.getRow(index: cellIndex, fieldWidth: state.width);

      if (removeLineMap[mapKey] == true) {
        newOccupiedCells.add(null);
        removedLines.add(mapKey);
        continue;
      }

      newOccupiedCells.add(occupiedCells[cellIndex]);
    }

    if (removedLines.isEmpty) {
      return newOccupiedCells;
    }

    state.audioCallback?.call();

    return _recalculateOccupiedCells(
      removedLines: removedLines,
      occupiedCells: newOccupiedCells,
    );
  }

  List<Color?> _recalculateOccupiedCells({required Set<int> removedLines, required List<Color?> occupiedCells}) {
    final lowestRemovedRowIndex = removedLines.reduce(max);
    final newOccupiedCells = [...occupiedCells];

    for (int cellIndex = newOccupiedCells.length; cellIndex > 0; cellIndex--) {
      final mapKey = GameFieldHelper.getRow(index: cellIndex, fieldWidth: state.width);

      if (mapKey < lowestRemovedRowIndex && newOccupiedCells[cellIndex] != null) {
        final cellValue = newOccupiedCells[cellIndex];

        occupiedCells[cellIndex] = null;
        occupiedCells[cellIndex + state.width * removedLines.length] = cellValue;
      }
    }

    return occupiedCells;
  }

  bool _isUpdateScreenCollisions({
    required List<Color?> occupiedCells,
    required List<int> coordinates,
  }) {
    late final isBottomScreenCollision = ScreenCollisionsHelper.isCollision(
      direction: DirectionEnum.down,
      coordinates: coordinates,
      fieldWidth: state.width,
      fieldHeight: state.height,
    );

    late final isOccupiedCollision = OccupiedCollisionsHelper.isDownCollision<Color?>(
      coordinates: coordinates,
      fieldWidth: state.width,
      occupied: occupiedCells,
    );

    return isBottomScreenCollision || isOccupiedCollision;
  }

  bool _isGameOver({
    required List<Color?> occupiedCells,
    required List<int> coordinates,
  }) {
    return coordinates.any((coordinate) {
      return !CollisionsHelper.isInsideOfField(coordinate: coordinate, maxCoordinate: occupiedCells.length);
    });
  }

  void _addNewShape({required Map<int, bool> removeLineMap, required List<Color?> occupiedCells}) {
    final newOccupiedCells = _removeLines(removeLineMap: removeLineMap, occupiedCells: occupiedCells);

    add(TetrisAddNewShape(occupiedCells: newOccupiedCells));
  }

  Shape _createNew() {
    final shape = ShapesHelper.getRandomShapeType();

    return Shape(
        color: ColorsHelper.getRandomColor(),
        type: shape,
        coordinates: PositionHelper.getCoordinates(shape: shape, fieldWidth: state.width, position: initialPosition));
  }
}
