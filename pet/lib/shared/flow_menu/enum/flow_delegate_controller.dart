import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet/shared/flow_menu/enum/flow_menu.enum.dart';

class CustomFlowDelegate extends FlowDelegate {
  static const _offset = 80.0;
  const CustomFlowDelegate(
      {required this.animation, required this.direction, this.offset = _offset})
      : super(repaint: animation);

  final Animation<double> animation;
  final FlowMenuDirectionsEnum direction;
  final double offset;

  @override
  void paintChildren(FlowPaintingContext context) {
    if (direction == FlowMenuDirectionsEnum.right) {
      for (int i = 0; i < context.childCount; i++) {
        final dx = (context.getChildSize(i)?.width ?? 0) * i;
        final gap = direction.value * animation.value * dx;

        context.paintChild(i, transform: Matrix4.translationValues(gap, 0, 0));
      }
    } else {
      for (int i = 0; i < context.childCount; i++) {
        final start =
            context.size.width - (context.getChildSize(i)?.width ?? 0);
        final dx = (context.getChildSize(i)?.width ?? 0) * i;
        final double gap = start + direction.value * animation.value * dx;

        context.paintChild(i, transform: Matrix4.translationValues(gap, 0, 0));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
