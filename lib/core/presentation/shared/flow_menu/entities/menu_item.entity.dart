import 'package:flutter/material.dart';

class FlowMenuItem {
  const FlowMenuItem({required this.icon, required this.handler});

  final VoidCallback handler;
  final IconData icon;
}
