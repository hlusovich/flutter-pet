import 'package:flutter/material.dart';

class SelectionDot extends StatelessWidget {
  const SelectionDot({
    super.key,
    required this.size,
    required this.splashArea,
    required this.color,
    required this.onPressed,
  });

  final double size;
  final double splashArea;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.all(splashArea),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
