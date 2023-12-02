enum ShapesEnum {
  l,
  j,
  i,
  o,
  s,
  z,
  t;

  int get length {
    switch(this) {
      case ShapesEnum.l:
        return 4;
      default:
        return 0;
    }
  }
}
