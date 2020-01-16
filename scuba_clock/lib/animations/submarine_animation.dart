import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class SubmarineAnimation extends StatelessWidget {
  final int remainderValue;

  //var child;

  SubmarineAnimation({this.remainderValue});

  static final boxDecoration = BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 5,
            offset: Offset(0, 8),
            spreadRadius: 2)
      ]);

  @override
  Widget build(BuildContext context) {
    Widget myChild;

    print('The remainder is: $remainderValue');

    if (remainderValue.remainder(2) == 0) {
      myChild = ControlledAnimation(
        duration: Duration(milliseconds: 4000),
        tween: Tween(begin: 0.0, end: 80.0),
        builder: (context, height) {
         
              return Container(
                decoration: boxDecoration,
                width: 80.0,
                height: height,
                child: Container(),
              );
          
        },
      );
    } else {
      myChild = Container();
    }

    return new Container(child: myChild);
  }
}

