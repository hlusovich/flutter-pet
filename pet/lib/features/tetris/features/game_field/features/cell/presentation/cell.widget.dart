import 'package:flutter/widgets.dart';

class Cell extends StatelessWidget {
  final Color color;

  const Cell({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color),
    );
  }
}
