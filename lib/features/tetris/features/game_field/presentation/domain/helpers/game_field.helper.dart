abstract final class GameFieldHelper {
  static int getRow({required int index, required int fieldWidth}) {
    return (index / fieldWidth).floor();
  }
}
