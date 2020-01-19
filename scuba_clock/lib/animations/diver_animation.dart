import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class DiverAnimation extends StatelessWidget {
  final int seedValue;

  const DiverAnimation({
    @required this.seedValue,
  }) : assert(seedValue != null);

  @override
  Widget build(BuildContext context) {
    Widget myChild;

    var random = new Random(seedValue);
  

    final startPointX = 0.0 * random.nextDouble();
    final startPointY = 0.0 * random.nextDouble();

    final endPointX = 40.0 * random.nextDouble();
    final endPointY = -40.0 * random.nextDouble();
    print('endPointY  is: $endPointY');

    final startPosition = Offset(startPointX, startPointY);
    final endPosition = Offset(endPointX, endPointY);
    final duration = Duration(seconds: 5 + random.nextInt(5));

    var tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOut),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeInOut),
    ]);

    myChild = ControlledAnimation(
      playback: Playback.MIRROR,
      duration: duration,
      tween: tween,
      builder: (context, animation) {
        return Transform.translate(
          offset: Offset(animation["x"], animation["y"]),
          child: Diver(),
        );
      },
    );

    return new Container(child: myChild);
  }
}

class Diver extends StatelessWidget {
  const Diver({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
      width: 66.0,
      height: 28.0,
      child: Image.asset(
        'assets/images/diver.png',
        fit: BoxFit.cover,
        semanticLabel: 'An image of a small scuba diver',
      ),
    );
  }
}
