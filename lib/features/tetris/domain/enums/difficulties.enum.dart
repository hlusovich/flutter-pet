enum DifficultiesEnum {
  easy,
  medium,
  hard;

  String get name {
    switch (this) {
      case DifficultiesEnum.easy:
        return 'Easy';
      case DifficultiesEnum.medium:
        return 'Medium';
      case DifficultiesEnum.hard:
        return 'Hard';
    }
  }

  int get updateSpeed {
    switch (this) {
      case DifficultiesEnum.easy:
        return 900;
      case DifficultiesEnum.medium:
        return 300;
      case DifficultiesEnum.hard:
        return 200;
    }
  }
}