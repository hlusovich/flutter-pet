import 'dart:math';

import 'package:game_box/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';

abstract final class ShapesHelper {
  static ShapesEnum getRandomShapeType() {
    return ShapesEnum.values[Random().nextInt(ShapesEnum.values.length)];
  }
}
