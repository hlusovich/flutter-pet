import 'package:flutter/widgets.dart';
import 'package:pet/features/tetris/features/game_field/presentation/enums/shape.enum.dart';

class Shape extends StatelessWidget {
  final ShapesEnum shape;
  final int initialPosition;

  const Shape({
    required this.shape,
    required this.initialPosition,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
