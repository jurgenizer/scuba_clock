import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

import '../styles.dart';

class BackgroundAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds:20),
          ColorTween(begin: Styles.deepKoamaru, end: Styles.azureCyan)),
      Track("color2").add(Duration(seconds: 20),
          ColorTween(begin: Styles.middleRedPurple, end: Styles.seaGreen))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}


