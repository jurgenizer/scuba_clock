import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import '../styles.dart';

class DotAnimation extends StatelessWidget {
  final double speed;
  final double offset;

  DotAnimation({this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (1000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = Styles.secondDots;

    final y1 = sin(value);

    final controlPointY = size.height * (0.5 + 0.3 * y1);

    final controlPosition = Offset(size.width / 2, controlPointY);

    canvas.drawCircle(controlPosition, size.width * 0.2, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
