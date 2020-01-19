import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


class SubmarineAnimation extends StatelessWidget {
  final int remainderValue;
  final Random random;

  SubmarineAnimation({this.remainderValue, this.random});

  @override
  Widget build(BuildContext context) {
    Widget myChild;

    /// Get the size of the screen
    var screenSize = MediaQuery.of(context).size;

    final startPointX = screenSize.longestSide;
    final startPointY = screenSize.shortestSide / 2 - 120;
    print('The height of sub start point is: $startPointY');

    final endPointX = screenSize.longestSide - screenSize.longestSide - 150;
    final endPointY = screenSize.shortestSide / 2 ;

    final startPosition = Offset(startPointX, startPointY);
    final endPosition = Offset(endPointX, endPointY);
    final duration = Duration(milliseconds: 10000);

    print('The remainder is: $remainderValue');

    if (remainderValue.remainder(2) == 0) {
      var tween = MultiTrackTween([
        Track("x").add(
            duration, Tween(begin: startPosition.dx, end: endPosition.dx),
            curve: Curves.linear),
        Track("y").add(
            duration, Tween(begin: startPosition.dy, end: endPosition.dy),
            curve: Curves.linear),
      ]);

      myChild = ControlledAnimation(
        duration: duration,
        tween: tween,
        builder: (context, animation) {
          return Transform.translate(
            offset: Offset(animation["x"], animation["y"]),
            child:  Submarine(),
          );
        },
      );
    } else {
      myChild = Container();
    }

    return new Container(child: myChild);
  }
}

class Submarine extends StatelessWidget {
  const Submarine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 59.0,
      child: Image.asset(
        'assets/images/sub.png',
        fit: BoxFit.cover,
        semanticLabel: 'An image of a small submarine',
      ),
    );
  }
}
