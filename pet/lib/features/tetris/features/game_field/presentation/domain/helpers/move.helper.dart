
import 'package:game_box/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';

abstract final class MoveHelper {
  static List<int> move({
    required List<int> coordinates,
    required DirectionEnum direction,
    required int fieldWidth,
  }) {
    switch (direction) {
      case DirectionEnum.right:
        return _moveRight(coordinates);
      case DirectionEnum.left:
        return _moveLeft(coordinates);
      case DirectionEnum.down:
        return _moveDown(coordinates: coordinates, fieldWidth: fieldWidth);
    }
  }

  static List<int> _moveLeft(List<int> coordinates) {
    return coordinates.map((coordinate) => coordinate - 1).toList();
  }

  static List<int> _moveRight(List<int> coordinates) {
    return coordinates.map((coordinate) => coordinate + 1).toList();
  }

  static List<int> _moveDown({
    required List<int> coordinates,
    required int fieldWidth,
  }) {
    return coordinates.map((coordinate) => coordinate + fieldWidth).toList();
  }
}
