import 'package:flutter/material.dart';
import 'package:pet/shared/selection_dots/selection_dot/selection_dot.dart';

class SelectionDots extends StatefulWidget {
  static const _defaultGap = 8.0;
  static const _defaultSize = 9.0;

  const SelectionDots({
    super.key,
    required this.count,
    required this.color,
    required this.activeColor,
    this.size = _defaultSize,
    this.gap = _defaultGap,
    this.selectedDotIndex = 0,
    this.dotSelectdelayTime = 500,
    this.onPressed,
  });

  final int count;
  final int selectedDotIndex;
  final int dotSelectdelayTime;

  final double size;
  final double gap;

  final Color color;
  final Color activeColor;

  final void Function(int index)? onPressed;

  @override
  State<SelectionDots> createState() => _SelectionDotsState();
}

class _SelectionDotsState extends State<SelectionDots> {
  int selectedDotIndex = 0;

  @override
  void initState() {
    super.initState();

    selectedDotIndex = widget.selectedDotIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.count; i++)
          SelectionDot(
              color: selectedDotIndex == i ? widget.activeColor : widget.color,
              size: widget.size,
              splashArea: widget.gap / 2,
              onPressed: () {
                widget.onPressed?.call(i);
                Future.delayed(Duration(
                  milliseconds: widget.dotSelectdelayTime,
                )).then((_) => setState(() {
                      selectedDotIndex = i;
                    }));
              }),
      ],
    );
  }
}
