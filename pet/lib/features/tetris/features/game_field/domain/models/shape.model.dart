import 'dart:ui';

import 'package:equatable/equatable.dart';

class Shape extends Equatable {
  final Color color;
  final List<int> coordinates;

  const Shape({required this.color, required this.coordinates});

  @override
  List<Object> get props => [color, ...coordinates];

  Shape copyWith({
    Color? color,
    List<int>? coordinates,
  }) {
    return Shape(
      color: color ?? this.color,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
