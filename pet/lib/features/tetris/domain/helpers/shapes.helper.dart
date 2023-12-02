import 'dart:math';

import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';

abstract final class ShapesHelper {
  static ShapesEnum getRandomShape() {
    return ShapesEnum.values[Random().nextInt(ShapesEnum.values.length)];
  }
}
