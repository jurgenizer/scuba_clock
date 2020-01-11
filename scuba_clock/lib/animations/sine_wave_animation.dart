import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class SineWaveAnimation extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  SineWaveAnimation({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (60000 / speed).round()),
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
    final white = Paint()..color = Colors.white.withAlpha(10);
    // final white = Paint()..color = Colors.white
     // ..strokeWidth = 1.5
      //..style = PaintingStyle.stroke
      //..strokeCap = StrokeCap.round;
    final path = Path();

    final y1 = sin(value);
 
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);
    final y4 = sin(value + (3 * pi) / 2);
    final y5 = sin(value + 2 * pi);

    final startPointY = size.height / 2;
    final controlPointY2 = size.height * (0.5 + 0.4 * y2);
    final midPointY = size.height * (0.5 + 0.4 * y3);
    final controlPointY4 = size.height * (0.5 + 0.4 * y4);

     final endPointY = size.height * (0.5 + 0.4 * y5);

    path.moveTo(size.width * 0, startPointY);
    //  print("size.width = ${size.width}");
    //path.quadraticBezierTo(size.width * 0.5, controlPointY, size.width, endPointY);

    path.cubicTo(size.width * 0.4, controlPointY2, size.width * 0.6, controlPointY4, size.width, startPointY);
   path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
   path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}