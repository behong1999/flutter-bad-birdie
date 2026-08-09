import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/models/board_element.dart';

class BoardPainter extends CustomPainter {
  const BoardPainter({
    required this.elements,
    this.currentStroke,
    this.arrowPreviewStart,
    this.arrowPreviewEnd,
    this.previewColor = Colors.white,
    this.previewStrokeWidth = 3.5,
  });

  final List<BoardElement> elements;
  final FreehandStroke? currentStroke;
  final Offset? arrowPreviewStart;
  final Offset? arrowPreviewEnd;
  final Color previewColor;
  final double previewStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    for (final element in elements) {
      switch (element) {
        case FreehandStroke(:final points, :final color, :final strokeWidth):
          _paintStroke(canvas, size, points, color, strokeWidth);
        case ArrowElement(
          :final start,
          :final end,
          :final color,
          :final strokeWidth,
        ):
          _paintArrow(canvas, size, start, end, color, strokeWidth);
        case PlayerMarker():
          break;
      }
    }

    if (currentStroke != null) {
      _paintStroke(
        canvas,
        size,
        currentStroke!.points,
        currentStroke!.color,
        currentStroke!.strokeWidth,
      );
    }

    if (arrowPreviewStart != null && arrowPreviewEnd != null) {
      _paintArrow(
        canvas,
        size,
        arrowPreviewStart!,
        arrowPreviewEnd!,
        previewColor,
        previewStrokeWidth,
      );
    }
  }

  void _paintStroke(
    Canvas canvas,
    Size size,
    List<Offset> points,
    Color color,
    double strokeWidth,
  ) {
    if (points.length < 2) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(points[0].dx * size.width, points[0].dy * size.height);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx * size.width, points[i].dy * size.height);
    }
    canvas.drawPath(path, paint);
  }

  void _paintArrow(
    Canvas canvas,
    Size size,
    Offset start,
    Offset end,
    Color color,
    double strokeWidth,
  ) {
    final s = Offset(start.dx * size.width, start.dy * size.height);
    final e = Offset(end.dx * size.width, end.dy * size.height);
    if ((e - s).distance < 4) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final angle = math.atan2(e.dy - s.dy, e.dx - s.dx);
    const headLen = 14.0;
    const headAngle = 0.42; // radians ≈ 24°

    canvas
      ..drawLine(s, e, paint)
      ..drawLine(e, e - Offset.fromDirection(angle - headAngle, headLen), paint)
      ..drawLine(
        e,
        e - Offset.fromDirection(angle + headAngle, headLen),
        paint,
      );
  }

  @override
  bool shouldRepaint(BoardPainter old) => true;
}
