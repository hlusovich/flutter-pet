import 'dart:ui';

import 'package:game_box/features/tetris/features/game_field/domain/models/shape.model.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';

abstract interface class TetrisGameFieldEvents {
  const TetrisGameFieldEvents();
}

final class UpdateGameFieldSize extends TetrisGameFieldEvents {
  final int width;

  final int height;

  const UpdateGameFieldSize({
    required this.height,
    required this.width,
  });
}

final class TetrisStartFrameUpdate extends TetrisGameFieldEvents {
  const TetrisStartFrameUpdate();
}

final class TetrisCancelFrameUpdate extends TetrisGameFieldEvents {
  const TetrisCancelFrameUpdate();
}

final class RemoveLines extends TetrisGameFieldEvents {
  const RemoveLines();
}

final class TetrisCreateNewShape extends TetrisGameFieldEvents {
  const TetrisCreateNewShape();
}

final class TetrisResetField extends TetrisGameFieldEvents {
  const TetrisResetField();
}

final class TetrisAddAudioCallbackField extends TetrisGameFieldEvents {
  final VoidCallback audioCallback;

  const TetrisAddAudioCallbackField({required this.audioCallback});
}

final class TetrisUpdateOccupiedFields extends TetrisGameFieldEvents {
  final List<Color?> occupiedCells;

  const TetrisUpdateOccupiedFields({
    required this.occupiedCells,
  });
}

final class TetrisAddNewShape extends TetrisGameFieldEvents {
  final List<Color?>? occupiedCells;

  const TetrisAddNewShape({this.occupiedCells});
}

final class TetrisUpdateCurrentShape extends TetrisGameFieldEvents {
  final Shape? currentShape;

  const TetrisUpdateCurrentShape({required this.currentShape});
}

final class TetrisUpdateCurrentShapeByDirection extends TetrisGameFieldEvents {
  final DirectionEnum direction;

  const TetrisUpdateCurrentShapeByDirection({required this.direction});
}
