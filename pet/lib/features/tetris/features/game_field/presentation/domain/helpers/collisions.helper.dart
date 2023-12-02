import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/direction.enum.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/game_field.helper.dart';

abstract final class CollisionsHelper {
  static bool isScreenCollision({
    required DirectionEnum direction,
    required List<int> coordinates,
    required int fieldWidth,
    required int fieldHeight,
  }) {
    switch (direction) {
      case DirectionEnum.right:
        return _isRightScreenCollision(coordinates: coordinates, fieldWidth: fieldWidth);
      case DirectionEnum.left:
        return _isLeftScreenCollision(coordinates: coordinates, fieldWidth: fieldWidth);
      case DirectionEnum.down:
        return _isDownScreenCollision(coordinates: coordinates, fieldWidth: fieldWidth, fieldHeight: fieldHeight);
    }
  }

  static bool isOccupiedCollision<T>({
    required List<int> coordinates,
    required List<T> occupied,
    required int fieldWidth,
  }) {
    return coordinates.any(((coordinate) =>
        isOutOfFieldCollision(
          coordinate: coordinate,
          maxCoordinate: occupied.length,
          fieldWidth: fieldWidth,
        ) &&
        occupied[coordinate + fieldWidth] != null));
  }

  static bool isInsideOfFieldCollision({
    required int coordinate,
    required int maxCoordinate,
  }) {
    return maxCoordinate > coordinate && coordinate > 0;
  }

  static bool isOutOfFieldCollision({
    required int coordinate,
    required int maxCoordinate,
    required int fieldWidth,
  }) {
    return (coordinate + fieldWidth > 0) && (maxCoordinate > (coordinate + fieldWidth));
  }

  static bool _isRightScreenCollision({required List<int> coordinates, required int fieldWidth}) {
    return coordinates.any(((coordinate) =>
        GameFieldHelper.getRow(index: coordinate + 1, fieldWidth: fieldWidth) >
        GameFieldHelper.getRow(index: coordinate, fieldWidth: fieldWidth)));
  }

  static bool _isLeftScreenCollision({required List<int> coordinates, required int fieldWidth}) {
    return coordinates.any(((coordinate) =>
        GameFieldHelper.getRow(index: coordinate - 1, fieldWidth: fieldWidth) <
        GameFieldHelper.getRow(index: coordinate, fieldWidth: fieldWidth)));
  }

  static bool _isDownScreenCollision(
      {required List<int> coordinates, required int fieldWidth, required int fieldHeight}) {
    return coordinates.any(((coordinate) =>
        GameFieldHelper.getRow(index: coordinate + fieldWidth, fieldWidth: fieldWidth) >= fieldHeight));
  }
}
