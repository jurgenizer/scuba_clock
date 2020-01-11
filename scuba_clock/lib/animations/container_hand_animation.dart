import 'dart:math';
import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

import '../hand.dart';

class ContainerHandAnimation extends Hand {
  const ContainerHandAnimation({
    @required Color color,
    @required double size,
    @required double angleRadians,
    this.child,
  })  : assert(size != null),
        assert(angleRadians != null),
        super(
          color: color,
          size: size,
          angleRadians: angleRadians,
        );

  /// The child widget used as the clock hand and rotated by [angleRadians], see below.
  /// In this case the child widget will be an animated dot and the rotation
  /// will be handled by the animated tween (2 * pi radians in 60 seconds).
  /// 
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("rotation")
          .add(Duration(seconds: 60), Tween(begin: 0.0, end: 2 * pi))
           
    ]);

    return ControlledAnimation(
      playback: Playback.LOOP,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Transform.rotate(
          angle: animation["rotation"],
          child: Center(
            child: SizedBox.expand(
              child: Transform.rotate(
                angle: angleRadians,
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: size,
                  alignment: Alignment.center,
                  child: Container(
                    color: color,
                    child: Center(child: child),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
