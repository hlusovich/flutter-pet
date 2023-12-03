import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/enums/rotation.enum.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';

final class Shape extends Equatable {
  final Color color;
  final List<int> coordinates;
  final RotationEnum rotationState;
  final ShapesEnum type;

  const Shape({
    required this.color,
    required this.coordinates,
    required this.type,
    this.rotationState = RotationEnum.initial,
  });

  @override
  List<Object> get props => [color, rotationState, ...coordinates];

  Shape copyWith({
    Color? color,
    List<int>? coordinates,
    RotationEnum? rotationState,
    ShapesEnum? type,
  }) {
    return Shape(
      color: color ?? this.color,
      coordinates: coordinates ?? this.coordinates,
      rotationState: rotationState ?? this.rotationState,
      type: type ?? this.type,
    );
  }
}
