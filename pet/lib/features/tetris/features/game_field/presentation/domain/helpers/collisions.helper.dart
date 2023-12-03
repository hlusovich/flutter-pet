

abstract final class CollisionsHelper {
  static bool isInsideOfField({
    required int coordinate,
    required int maxCoordinate,
  }) {
    return maxCoordinate > coordinate && coordinate > 0;
  }

  static bool isOutOfField({
    required int coordinate,
    required int maxCoordinate,
    required int fieldWidth,
  }) {
    return (coordinate + fieldWidth > 0) && (maxCoordinate > (coordinate + fieldWidth));
  }
}
