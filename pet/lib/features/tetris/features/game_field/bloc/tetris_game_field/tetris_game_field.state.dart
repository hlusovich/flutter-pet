import 'dart:ui';

import 'package:game_box/features/tetris/features/game_field/domain/models/shape.model.dart';

final class TetrisGameFieldState {
  final int width;

  final int height;

  final List<Color?> occupiedCells;

  final Shape? currentShape;

  final VoidCallback? audioCallback;

  TetrisGameFieldState({
    required this.width,
    required this.height,
    required this.occupiedCells,
    this.audioCallback,
    this.currentShape,
  });

  TetrisGameFieldState copyWith({
    int? width,
    int? height,
    List<Color?>? occupiedCells,
    Shape? currentShape,
    VoidCallback? audioCallback,
  }) {
    return TetrisGameFieldState(
      width: width ?? this.width,
      height: height ?? this.height,
      occupiedCells: occupiedCells ?? this.occupiedCells,
      currentShape: currentShape ?? this.currentShape,
      audioCallback: audioCallback ?? this.audioCallback,
    );
  }
}
