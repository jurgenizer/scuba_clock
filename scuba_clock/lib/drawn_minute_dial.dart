import 'dart:math';

import 'package:flutter/material.dart';

class DrawnMinuteDial extends StatelessWidget {
  const DrawnMinuteDial({
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

  final double smallTickLength = 8.0;
  final double smallTickWidth = 3.0;
   final double largeTickLength = 8.0;
  final double largeTickWidth = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final smallAngle = 2 * pi / 60;
    final largeAngle = 2 * pi / 12;
    final radius = ((size.shortestSide / 2) * dialSize) -22;
    final middleX = (max(size.width, size.height) / 2);
    final middleY = (min(size.width, size.height) / 2);
    canvas.save();

    final smallTickPaint = Paint()
      ..color = color
      ..strokeWidth = smallTickWidth
      ..strokeCap = StrokeCap.round;

        final largeTickPaint = Paint()
      ..color = color
      ..strokeWidth = largeTickWidth
      ..strokeCap = StrokeCap.round;

    // drawing
    canvas.translate(middleX, middleY);

    // the first 15 marks using smallAngle
    for (var i = 0; i < 15; i++) {
      tickMarkLength = smallTickLength;

      canvas.drawLine(new Offset(0.0, -radius),
          new Offset(0.0, -radius + tickMarkLength), smallTickPaint);

      canvas.rotate(smallAngle);
    }

    // the 12 major marks using largeAngle
    for (var j = 0; j < 12; j++) {
      tickMarkLength = largeTickLength;

      canvas.drawLine(new Offset(0.0, -radius),
          new Offset(0.0, -radius + tickMarkLength), largeTickPaint);

      canvas.rotate(largeAngle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_DialPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
