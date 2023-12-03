import 'package:pet/features/tetris/features/game_field/domain/models/shape.model.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/rotation.enum.dart';
import 'package:pet/features/tetris/features/game_field/presentation/domain/enums/shape.enum.dart';

abstract final class RotationHelper {
  static Shape rotateShape({
    required Shape shape,
    required int fieldWidth,
  }) {
    switch (shape.type) {
      case ShapesEnum.l:
        return _rotateLShape(shape: shape, fieldWidth: fieldWidth);
      case ShapesEnum.s:
        return _rotateSShape(shape: shape, fieldWidth: fieldWidth);
      case ShapesEnum.z:
        return _rotateZShape(shape: shape, fieldWidth: fieldWidth);
      case ShapesEnum.j:
        return _rotateJShape(shape: shape, fieldWidth: fieldWidth);
      case ShapesEnum.i:
        return _rotateIShape(shape: shape, fieldWidth: fieldWidth);
      case ShapesEnum.t:
        return _rotateTShape(shape: shape, fieldWidth: fieldWidth);
      case ShapesEnum.o:
        return shape;
    }
  }

  static Shape _rotateLShape({
    required Shape shape,
    required int fieldWidth,
  }) {
    final pivot = shape.coordinates[1];

    switch (shape.rotationState) {
      case RotationEnum.initial:
        return shape.copyWith(
          rotationState: RotationEnum.right,
          coordinates: [
            pivot - 1,
            pivot,
            pivot + 1,
            pivot + fieldWidth - 1,
          ],
        );

      case RotationEnum.right:
        return shape.copyWith(
          rotationState: RotationEnum.opposite,
          coordinates: [
            pivot - fieldWidth,
            pivot,
            pivot + fieldWidth,
            pivot + fieldWidth + 1,
          ],
        );
      case RotationEnum.opposite:
        return shape.copyWith(
          rotationState: RotationEnum.left,
          coordinates: [
            pivot - fieldWidth + 1,
            pivot,
            pivot + 1,
            pivot - 1,
          ],
        );

      case RotationEnum.left:
        return shape.copyWith(
          rotationState: RotationEnum.initial,
          coordinates: [
            pivot + fieldWidth,
            pivot,
            pivot - fieldWidth,
            pivot - fieldWidth - 1,
          ],
        );
    }
  }

  static Shape _rotateJShape({
    required Shape shape,
    required int fieldWidth,
  }) {
    final pivot = shape.coordinates[1];
    switch (shape.rotationState) {
      case RotationEnum.initial:
        return shape.copyWith(
          rotationState: RotationEnum.right,
          coordinates: [
            pivot + fieldWidth,
            pivot,
            pivot - fieldWidth,
            pivot - fieldWidth + 1,
          ],
        );

      case RotationEnum.right:
        return shape.copyWith(
          rotationState: RotationEnum.opposite,
          coordinates: [
            pivot - fieldWidth - 1,
            pivot,
            pivot - 1,
            pivot + 1,
          ],
        );
      case RotationEnum.opposite:
        return shape.copyWith(
          rotationState: RotationEnum.left,
          coordinates: [
            pivot - fieldWidth,
            pivot,
            pivot + fieldWidth,
            pivot + fieldWidth - 1,
          ],
        );

      case RotationEnum.left:
        return shape.copyWith(
          rotationState: RotationEnum.initial,
          coordinates: [
            pivot + 1,
            pivot,
            pivot - 1,
            pivot + fieldWidth + 1,
          ],
        );
    }
  }

  static Shape _rotateIShape({
    required Shape shape,
    required int fieldWidth,
  }) {
    final pivot = shape.coordinates[1];
    switch (shape.rotationState) {
      case RotationEnum.initial:
        return shape.copyWith(
          rotationState: RotationEnum.right,
          coordinates: [
            pivot - fieldWidth,
            pivot,
            pivot + fieldWidth,
            pivot + 2 * fieldWidth,
          ],
        );

      case RotationEnum.right:
        return shape.copyWith(
          rotationState: RotationEnum.opposite,
          coordinates: [
            pivot + 1,
            pivot,
            pivot - 1,
            pivot - 2,
          ],
        );
      case RotationEnum.opposite:
        return shape.copyWith(
          rotationState: RotationEnum.left,
          coordinates: [
            pivot + fieldWidth,
            pivot,
            pivot - fieldWidth,
            pivot - 2 * fieldWidth,
          ],
        );

      case RotationEnum.left:
        return shape.copyWith(
          rotationState: RotationEnum.initial,
          coordinates: [
            pivot - 1,
            pivot,
            pivot + 1,
            pivot + 2,
          ],
        );
    }
  }

  static Shape _rotateTShape({
    required Shape shape,
    required int fieldWidth,
  }) {
    switch (shape.rotationState) {
      case RotationEnum.initial:
        final pivot = shape.coordinates[1];
        return shape.copyWith(
          rotationState: RotationEnum.right,
          coordinates: [
            pivot - 1,
            pivot,
            pivot + 1,
            pivot + fieldWidth,
          ],
        );

      case RotationEnum.right:
        final pivot = shape.coordinates[2];
        return shape.copyWith(
          rotationState: RotationEnum.opposite,
          coordinates: [
            pivot - fieldWidth,
            pivot - 1,
            pivot,
            pivot + 1,
          ],
        );
      case RotationEnum.opposite:
        final pivot = shape.coordinates[1];
        return shape.copyWith(
          rotationState: RotationEnum.left,
          coordinates: [
            pivot - fieldWidth,
            pivot,
            pivot + 1,
            pivot + fieldWidth,
          ],
        );

      case RotationEnum.left:
        final pivot = shape.coordinates[2];

        return shape.copyWith(
          rotationState: RotationEnum.initial,
          coordinates: [
            pivot - fieldWidth,
            pivot - 1,
            pivot,
            pivot + 1,
          ],
        );
    }
  }

  static Shape _rotateSShape({
    required Shape shape,
    required int fieldWidth,
  }) {
    switch (shape.rotationState) {
      case RotationEnum.initial:
        final pivot = shape.coordinates[1];
        return shape.copyWith(
          rotationState: RotationEnum.right,
          coordinates: [pivot, pivot + 1, pivot + fieldWidth - 1, pivot + fieldWidth],
        );

      case RotationEnum.right:
        final pivot = shape.coordinates[0];
        return shape.copyWith(
          rotationState: RotationEnum.opposite,
          coordinates: [pivot - fieldWidth, pivot, pivot + 1, pivot + fieldWidth + 1],
        );
      case RotationEnum.opposite:
        final pivot = shape.coordinates[1];
        return shape.copyWith(
          rotationState: RotationEnum.left,
          coordinates: [pivot, pivot + 1, pivot + fieldWidth - 1, pivot + fieldWidth],
        );

      case RotationEnum.left:
        final pivot = shape.coordinates[0];
        return shape.copyWith(
          rotationState: RotationEnum.initial,
          coordinates: [pivot - fieldWidth, pivot, pivot + 1, pivot + fieldWidth + 1],
        );
    }
  }

  static Shape _rotateZShape({
    required Shape shape,
    required int fieldWidth,
  }) {
    switch (shape.rotationState) {
      case RotationEnum.initial:
        return shape.copyWith(
          rotationState: RotationEnum.right,
          coordinates: [
            shape.coordinates[0] - fieldWidth + 2,
            shape.coordinates[1],
            shape.coordinates[2] - fieldWidth + 1,
            shape.coordinates[3] - 1,
          ],
        );

      case RotationEnum.right:
        return shape.copyWith(rotationState: RotationEnum.opposite, coordinates: [
          shape.coordinates[0] + fieldWidth - 2,
          shape.coordinates[1],
          shape.coordinates[2] + fieldWidth - 1,
          shape.coordinates[3] + 1,
        ]);
      case RotationEnum.opposite:
        return shape.copyWith(rotationState: RotationEnum.left, coordinates: [
          shape.coordinates[0] - fieldWidth + 2,
          shape.coordinates[1],
          shape.coordinates[2] - fieldWidth + 1,
          shape.coordinates[3] - 1,
        ]);

      case RotationEnum.left:
        return shape.copyWith(rotationState: RotationEnum.initial, coordinates: [
          shape.coordinates[0] + fieldWidth - 2,
          shape.coordinates[1],
          shape.coordinates[2] + fieldWidth - 1,
          shape.coordinates[3] + 1,
        ]);
    }
  }
}
