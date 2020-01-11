import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class WaveAnimation extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  WaveAnimation({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return ClipPath(clipper: CurveClipper(value + offset),    child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),child: Container(
            alignment: Alignment.center,
            width: 200.0,
            height: 200.0,
            child: Text('Hello World'),
          ),
          ),);
            }),
      );
    });
  }
}


class CurveClipper extends CustomClipper<Path> {
  final double value;

  CurveClipper(this.value);
  @override
  Path getClip(Size size) {
    final path = Path();
    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CurveClipper oldClipper) => true;
}