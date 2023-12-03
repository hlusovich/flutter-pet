import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final Color color;

  const Cell({this.color = Colors.black, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}
