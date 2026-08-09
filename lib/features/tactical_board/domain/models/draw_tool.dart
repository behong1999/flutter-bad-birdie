import 'package:flutter/material.dart';

enum DrawTool {
  pencil(Icons.edit_outlined),
  arrow(Icons.trending_flat);

  const DrawTool(this.icon);

  final IconData icon;
}
