enum ThemeEnum {
  light,
  dark;

  String get name {
    switch (this) {
      case light:
        return 'Light';
      case dark:
        return 'Dark';
    }
  }
}
