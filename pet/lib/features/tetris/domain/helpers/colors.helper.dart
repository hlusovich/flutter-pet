import 'dart:math';
import 'dart:ui';

import 'package:game_box/features/tetris/features/game_field/domain/enums/colors.constants.dart';

abstract final class ColorsHelper {
  static Color getRandomColor() {
    return shapesColors[Random().nextInt(shapesColors.length)];
  }
}
