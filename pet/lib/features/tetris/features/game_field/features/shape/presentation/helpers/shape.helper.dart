import 'package:pet/features/tetris/features/game_field/presentation/enums/shape.enum.dart';

abstract final class PositionHelper {
  static List<int> getCoordinates({
    required ShapesEnum shape,
    required int fieldWidth,
    required int position,
  }) {
    switch (shape) {
      case ShapesEnum.l:
        return _getLShapeCoordinates(position: position, fieldWidth: fieldWidth);
      case ShapesEnum.j:
        return _getJShapeCoordinates(position: position, fieldWidth: fieldWidth);
      default:
        return [];
    }
  }

  static List<int> _getLShapeCoordinates({required int position, required int fieldWidth}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < ShapesEnum.l.length; i++) {
      if (i != ShapesEnum.l.length - 1) {
        shapeCoordinates.add(shapeCoordinates.last + fieldWidth);
      } else {
        shapeCoordinates.add(shapeCoordinates.last + 1);
      }
    }

    return shapeCoordinates;
  }

  static List<int> _getJShapeCoordinates({required int position, required int fieldWidth}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < ShapesEnum.l.length; i++) {
      if (i != ShapesEnum.l.length - 1) {
        shapeCoordinates.add(shapeCoordinates.last + fieldWidth);
      } else {
        shapeCoordinates.add(shapeCoordinates.last - 1);
      }
    }

    return shapeCoordinates;
  }
}
