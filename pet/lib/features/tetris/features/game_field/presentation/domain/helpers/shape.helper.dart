import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';

abstract final class PositionHelper {
  static int maxCoordinatesLength = 4;

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
      case ShapesEnum.o:
        return _getOShapeCoordinates(position: position, fieldWidth: fieldWidth);
      case ShapesEnum.s:
        return _getSShapeCoordinates(position: position, fieldWidth: fieldWidth);
      case ShapesEnum.z:
        return _getZShapeCoordinates(position: position, fieldWidth: fieldWidth);
      case ShapesEnum.t:
        return _getTShapeCoordinates(position: position, fieldWidth: fieldWidth);
      case ShapesEnum.i:
        return _getIShapeCoordinates(position: position);
    }
  }

  static List<int> _getLShapeCoordinates({required int position, required int fieldWidth}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < maxCoordinatesLength; i++) {
      if (i != maxCoordinatesLength - 1) {
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

    for (int i = 1; i < maxCoordinatesLength; i++) {
      if (i != maxCoordinatesLength - 1) {
        shapeCoordinates.add(shapeCoordinates.last + fieldWidth);
      } else {
        shapeCoordinates.add(shapeCoordinates.last - 1);
      }
    }

    return shapeCoordinates;
  }

  static List<int> _getIShapeCoordinates({required int position}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < maxCoordinatesLength; i++) {
      shapeCoordinates.add(shapeCoordinates.last + 1);
    }

    return shapeCoordinates;
  }

  static List<int> _getOShapeCoordinates({required int position, required int fieldWidth}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < maxCoordinatesLength; i++) {
      if (i == maxCoordinatesLength - 2) {
        shapeCoordinates.add(position + fieldWidth);
      } else {
        shapeCoordinates.add(shapeCoordinates.last + 1);
      }
    }

    return shapeCoordinates;
  }

  static List<int> _getSShapeCoordinates({required int position, required int fieldWidth}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < maxCoordinatesLength; i++) {
      if (i == maxCoordinatesLength - 2) {
        shapeCoordinates.add(position + fieldWidth + 1);
      } else {
        shapeCoordinates.add(shapeCoordinates.last + 1);
      }
    }

    return shapeCoordinates;
  }

  static List<int> _getTShapeCoordinates({required int position, required int fieldWidth}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < maxCoordinatesLength; i++) {
      if (i != maxCoordinatesLength - 1) {
        shapeCoordinates.add(shapeCoordinates.last + fieldWidth);
      } else {
        shapeCoordinates.add(shapeCoordinates.last + 1 - fieldWidth);
      }
    }

    return shapeCoordinates;
  }

  static List<int> _getZShapeCoordinates({required int position, required int fieldWidth}) {
    final shapeCoordinates = [
      position,
    ];

    for (int i = 1; i < maxCoordinatesLength; i++) {
      if (i == maxCoordinatesLength - 2) {
        shapeCoordinates.add(shapeCoordinates.last + fieldWidth);
      } else {
        shapeCoordinates.add(shapeCoordinates.last + 1);
      }
    }
    return shapeCoordinates;
  }
}
