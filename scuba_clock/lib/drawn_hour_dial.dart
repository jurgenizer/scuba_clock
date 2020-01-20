import 'dart:math';

import 'package:flutter/material.dart';

class DrawnHourDial extends StatelessWidget {
  const DrawnHourDial({
    @required this.color,
    @required this.size,
  })  : assert(color != null),
        assert(size != null);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _DialPainter(color: color, dialSize: size),
        ),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  _DialPainter({
    @required this.color,
    @required this.dialSize,
  })  : assert(color != null),
        assert(dialSize >= 0.0),
        assert(dialSize <= 1.0);

  Color color;

  double dialSize;

  final double tickLength = 8.0;
  final double tickWidth = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 12;
    final radius = ((size.shortestSide / 2) * dialSize) - 60;
    final middleX = (max(size.width, size.height) / 2);
    final middleY = (min(size.width, size.height) / 2);
    canvas.save();

    final tickPaint = Paint()
      ..color = color
      ..strokeWidth = tickWidth
      ..strokeCap = StrokeCap.round;

    /// Drawing the ticks
    canvas.translate(middleX, middleY);
    for (var i = 0; i < 12; i++) {
      tickMarkLength = tickLength;

      canvas.drawLine(new Offset(0.0, -radius),
          new Offset(0.0, -radius + tickMarkLength), tickPaint);

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_DialPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
