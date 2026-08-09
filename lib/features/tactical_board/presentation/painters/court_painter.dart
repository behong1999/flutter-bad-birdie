import 'package:flutter/material.dart';

// Portrait orientation: x = court width (6.1m), y = court length (13.4m)
//   x=0 left sideline, x=1 right sideline
//   y=0 top baseline, y=1 bottom baseline
class CourtPainter extends CustomPainter {
  const CourtPainter({required this.lineColor, required this.courtColor});

  final Color lineColor;
  final Color courtColor;

  static const _netY = 0.5;
  static const _shortServiceY = 1.98 / 13.4;
  static const _longServiceY = 0.76 / 13.4;
  static const _singlesX = 0.46 / 6.1;

  static const _ssTop = _netY - _shortServiceY;
  static const _ssBottom = _netY + _shortServiceY;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = courtColor,
    );

    final main = Paint()
      ..color = lineColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final w = size.width;
    final h = size.height;

    Offset p(double x, double y) => Offset(x * w, y * h);

    canvas
      // Outer boundary
      ..drawRect(Rect.fromLTWH(0, 0, w, h), main)
      // Singles sidelines (always present)
      ..drawLine(p(_singlesX, 0), p(_singlesX, 1), main)
      ..drawLine(p(1 - _singlesX, 0), p(1 - _singlesX, 1), main)
      // Short service lines
      ..drawLine(p(0, _ssTop), p(1, _ssTop), main)
      ..drawLine(p(0, _ssBottom), p(1, _ssBottom), main)
      // Long service lines (doubles back alleys)
      ..drawLine(p(0, _longServiceY), p(1, _longServiceY), main)
      ..drawLine(p(0, 1 - _longServiceY), p(1, 1 - _longServiceY), main)
      // Center service line at x=0.5 — runs baseline to short service line on each half
      ..drawLine(p(0.5, 0), p(0.5, _ssTop), main)
      ..drawLine(p(0.5, _ssBottom), p(0.5, 1), main);

    // Net (dashed horizontal)
    _drawDashed(canvas, p(0, _netY), p(1, _netY), main);
  }

  void _drawDashed(
    Canvas canvas,
    Offset from,
    Offset to,
    Paint paint, {
    double dash = 7,
    double gap = 5,
  }) {
    final total = (to - from).distance;
    if (total == 0) return;
    final dir = (to - from) / total;
    var dist = 0.0;
    while (dist < total) {
      final s = from + dir * dist;
      final e = from + dir * (dist + dash).clamp(0, total);
      canvas.drawLine(s, e, paint);
      dist += dash + gap;
    }
  }

  @override
  bool shouldRepaint(CourtPainter old) =>
      old.lineColor != lineColor || old.courtColor != courtColor;
}
