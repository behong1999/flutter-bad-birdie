import 'package:flutter/material.dart';

enum DrawTool {
  pencil(Icons.edit_outlined),
  arrow(Icons.trending_flat),
  shuttle(Icons.sports_tennis); // placeholder for shuttlecock tool

  const DrawTool(this.icon);

  final IconData icon;
}
