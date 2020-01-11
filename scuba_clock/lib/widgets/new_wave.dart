import 'dart:math';

import 'package:flutter/material.dart';

class NewWave extends StatelessWidget {
  const NewWave({
 
    @required this.size,
  })  : 
        assert(size != null);

 
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _DialPainter( dialSize: size),
        ),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  _DialPainter({
    
    @required this.dialSize,
  })  : 
        assert(dialSize >= 0.0),
        assert(dialSize <= 1.0);

  Color color;

  double dialSize;

 

  @override
  void paint(Canvas canvas, Size size) {
  
   // final value = (size.shortestSide) * dialSize;
  
   // canvas.save();


    // drawing
      final white = Paint()..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path();

    final y1 = sin(0);
    final y2 = sin(0+ pi / 2);
    final y3 = sin(0 + pi);

    final startPointPosY = size.height * (0.5 + 0.4 * y1);
    final controlPointPosY = size.height * (0.5 + 0.4 * y2);
    final endPointPosY = size.height * (0.5 + 0.4 * y3);

       final startPointNegY = size.height * (0.5 + 0.4 * -y1);
    final controlPointNegY = size.height * (-0.5 - 0.4 * -y2);
    final endPointNegY = size.height * (0.5 + 0.4 * -y3);

    path.moveTo(size.width * 0, startPointPosY);
    path.quadraticBezierTo(
        size.width * 0.25, controlPointPosY, size.width * 0.5, endPointPosY);
         path.quadraticBezierTo(
        size.width * 0.75, -controlPointNegY - 0.9, size.width * 1.0, endPointNegY);
   // path.lineTo(size.width, size.height);
   // path.lineTo(0, size.height);
    //path.close();
    canvas.drawPath(path, white);
   
    //canvas.restore();
  }

  @override
  bool shouldRepaint(_DialPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
