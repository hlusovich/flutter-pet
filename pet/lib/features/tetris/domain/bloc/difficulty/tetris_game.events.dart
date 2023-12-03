import 'package:game_box/features/tetris/domain/enums/difficulties.enum.dart';

abstract class TetrisDifficultyEvents {
  const TetrisDifficultyEvents();
}

final class UpdateTetrisDifficulty extends TetrisDifficultyEvents {
  final DifficultiesEnum difficulty;

  const UpdateTetrisDifficulty(this.difficulty);
}
