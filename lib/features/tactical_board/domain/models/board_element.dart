import 'package:flutter/material.dart';

sealed class BoardElement {
  const BoardElement();
}

final class FreehandStroke extends BoardElement {
  const FreehandStroke({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });

  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  FreehandStroke withPoints(List<Offset> points) =>
      FreehandStroke(points: points, color: color, strokeWidth: strokeWidth);
}

final class ArrowElement extends BoardElement {
  const ArrowElement({
    required this.start,
    required this.end,
    required this.color,
    required this.strokeWidth,
  });

  final Offset start;
  final Offset end;
  final Color color;
  final double strokeWidth;
}

final class PlayerMarker extends BoardElement {
  const PlayerMarker({
    required this.id,
    required this.label,
    required this.position,
    required this.color,
  });

  final String id;
  final String label;
  final Offset position;
  final Color color;

  PlayerMarker copyWith({String? label, Offset? position}) => PlayerMarker(
    id: id,
    label: label ?? this.label,
    position: position ?? this.position,
    color: color,
  );
}
