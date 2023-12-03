import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/collisions.helper.dart';

abstract final class OccupiedCollisionsHelper {
  static bool isDownCollision<T>({
    required List<int> coordinates,
    required List<T> occupied,
    required int fieldWidth,
  }) {
    return coordinates.any(((coordinate) =>
        CollisionsHelper.isOutOfField(
          coordinate: coordinate,
          maxCoordinate: occupied.length,
          fieldWidth: fieldWidth,
        ) &&
        occupied[coordinate + fieldWidth] != null));
  }

  static bool isRightCollision<T>({
    required List<int> coordinates,
    required List<T> occupied,
    required int fieldWidth,
  }) {
    return coordinates.any(((coordinate) =>
    CollisionsHelper.isInsideOfField(
          coordinate: coordinate,
          maxCoordinate: occupied.length,
        ) &&
        occupied[coordinate + 1] != null));
  }

  static bool isLeftCollision<T>({
    required List<int> coordinates,
    required List<T> occupied,
    required int fieldWidth,
  }) {
    return coordinates.any(((coordinate) =>
    CollisionsHelper.isInsideOfField(
          coordinate: coordinate,
          maxCoordinate: occupied.length,
        ) &&
        occupied[coordinate - 1] != null));
  }
}
