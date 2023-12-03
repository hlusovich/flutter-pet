import 'package:game_box/features/tetris/features/game_field/presentation/domain/helpers/game_field.helper.dart';

abstract final class RemoveLineHelper {
  static Map<int, bool> getRemoveLineMap<T>({
    required List<T> occupiedCells,
    required int fieldHeight,
    required int fieldWidth,
  }) {
    final Map<int, bool> removeLineMap = _initRemoveLineMap(fieldHeight);
    List<T> currentRowValues = [];

    for (int cellIndex = 0; cellIndex < occupiedCells.length; cellIndex++) {
      final mapKey = GameFieldHelper.getRow(index: cellIndex, fieldWidth: fieldWidth);
      currentRowValues.add(occupiedCells[cellIndex]);

      if (currentRowValues.length == fieldWidth) {
        removeLineMap[mapKey] = currentRowValues.every((element) => element != null);
        currentRowValues = [];
      }
    }

    return removeLineMap;
  }

  static Map<int, bool> _initRemoveLineMap<T>(int fieldHeight) {
    final Map<int, bool> removeLineMap = {};

    for (int currentColumn = 0; currentColumn < fieldHeight; currentColumn++) {
      removeLineMap[currentColumn] = true;
    }

    return removeLineMap;
  }
}
