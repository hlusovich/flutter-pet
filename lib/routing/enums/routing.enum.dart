enum RoutingEnum {
  home,
  tetris;

  get name {
    switch (this) {
      case home:
        return '/';
      case tetris:
        return '/tetris';
    }
  }
}
