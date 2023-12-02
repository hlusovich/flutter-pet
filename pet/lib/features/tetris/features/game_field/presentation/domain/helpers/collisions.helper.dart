import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';

abstract final class CollisionsHelper {
  static bool isCollision({
    required DirectionEnum direction,
    required List<int> coordinates,
    required int fieldWidth,
    required int fieldHeight,
  }) {
    switch (direction) {
      case DirectionEnum.right:
        return _isRightCollision(coordinates: coordinates, fieldWidth: fieldWidth);
      case DirectionEnum.left:
        return _isLeftCollision(coordinates: coordinates, fieldWidth: fieldWidth);
      case DirectionEnum.down:
        return _isDownCollision(coordinates: coordinates, fieldWidth: fieldWidth, fieldHeight: fieldHeight);
    }
  }

  static bool _isRightCollision({required List<int> coordinates, required int fieldWidth}) {
    return coordinates
        .any(((coordinate) => ((coordinate + 1) / fieldWidth).floor() > ((coordinate) / fieldWidth).floor()));
  }

  static bool _isLeftCollision({required List<int> coordinates, required int fieldWidth}) {
    return coordinates
        .any(((coordinate) => ((coordinate - 1) / fieldWidth).floor() < ((coordinate) / fieldWidth).floor()));
  }

  static bool _isDownCollision({required List<int> coordinates, required int fieldWidth, required int fieldHeight}) {
    return coordinates
        .any(((coordinate) => ((coordinate + fieldWidth) / fieldWidth).floor() >= fieldHeight));
  }
}
