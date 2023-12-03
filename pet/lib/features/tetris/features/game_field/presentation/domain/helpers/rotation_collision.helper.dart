import 'package:pet/features/tetris/features/game_field/domain/models/shape.model.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/helpers/collisions.helper.dart';

final class RotationCollisionHelper {
  static bool canBeRotated<T>({
    required Shape shape,
    required List<T> occupiedList,
    required List<int> oldCoordinates,
  }) {
    if (!_isNoScreenCollisions(coordinates: shape.coordinates, maxCoordinate: occupiedList.length)) {
      return false;
    }

    late final isOccupiedCollisions = _isOccupiedCollisions(
      coordinates: shape.coordinates,
      occupiedList: occupiedList,
      oldCoordinates: oldCoordinates,
    );

    return !isOccupiedCollisions;
  }

  static bool _isOccupiedCollisions<T>({
    required List<int> coordinates,
    required List<T> occupiedList,
    required List<int> oldCoordinates,
  }) {
    return coordinates.any((coordinate) => occupiedList[coordinate] != null && !oldCoordinates.contains(coordinate));
  }

  static bool _isNoScreenCollisions({required List<int> coordinates, required int maxCoordinate}) {
    return coordinates
        .every((coordinate) => CollisionsHelper.isInsideOfField(coordinate: coordinate, maxCoordinate: maxCoordinate));
  }
}
