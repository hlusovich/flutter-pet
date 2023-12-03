import 'package:game_box/features/tetris/domain/enums/difficulties.enum.dart';

abstract interface class TetrisDifficultyStates {
  const TetrisDifficultyStates();
}

final class TetrisInitialDifficultyState extends TetrisDifficultyStates {
  final DifficultiesEnum difficulty = DifficultiesEnum.easy;

  const TetrisInitialDifficultyState();
}

final class TetrisUpdateDifficultyState extends TetrisDifficultyStates {
  final DifficultiesEnum difficulty;

  const TetrisUpdateDifficultyState(this.difficulty);
}
