abstract interface class TetrisGameEvents {
  const TetrisGameEvents();
}

final class StartTetrisGame extends TetrisGameEvents {
  const StartTetrisGame();
}

final class EndTetrisGame extends TetrisGameEvents {
  const EndTetrisGame();
}
