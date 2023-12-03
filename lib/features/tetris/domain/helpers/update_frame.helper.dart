import 'package:game_box/features/tetris/domain/enums/difficulties.enum.dart';

abstract final class UpdateFrameHelper {
    static Duration getUpdateFrameDuration(DifficultiesEnum difficulty) {
          return Duration(milliseconds: difficulty.updateSpeed);
    }
}
