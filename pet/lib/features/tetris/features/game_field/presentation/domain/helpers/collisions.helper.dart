

abstract final class CollisionsHelper {
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
}
