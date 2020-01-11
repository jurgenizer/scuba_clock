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

  final double tickLength = 8.0;
  final double tickWidth = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = ((size.shortestSide / 2) * dialSize) + 10;
    final middleX = (max(size.width, size.height) / 2 );
    final middleY =(min(size.width, size.height) / 2 );
    canvas.save();

    final tickPaint = Paint()
      ..color = color
      ..strokeWidth = tickWidth
      ..strokeCap = StrokeCap.round;

    // drawing
    canvas.translate(middleX, middleY);
    for (var i = 0; i < 60; i++) {
      // make the length and stroke of the tick marker longer and thicker depending
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
