import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/features/tetris/features/game_field/domain/models/shape.model.dart';
import 'package:game_box/features/tetris/features/game_field/features/cell/presentation/cell.widget.dart';

class GameField extends StatelessWidget {
  final int width;
  final int height;
  final List<Color?> occupiedCells;
  final Shape? shape;

  const GameField({required this.occupiedCells, this.shape, this.width = 10, this.height = 15, super.key});

  int get itemCount => height * width;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeBloc>().state.theme;

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: itemCount,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: width),
            itemBuilder: (context, index) => Center(
              child: Padding(
                padding: const EdgeInsets.all(2),
                    child: Builder(builder: (_) {
                      final currentShape = shape;

                      if (currentShape == null) {
                        return const Cell();
                      }

                      if (currentShape.coordinates.contains(index)) {
                        return Cell(
                          color: currentShape.color,
                        );
                  }

                  final occupiedColor = occupiedCells[index];

                  if (occupiedColor != null) {
                    return Cell(
                      color: occupiedColor,
                    );
                  }

                  return Cell(
                    color: theme.card,
                  );
                }),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
