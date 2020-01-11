import 'dart:math';

import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';


class BubbleAnimation extends StatefulWidget {
  final int numberOfBubbles;

  BubbleAnimation(this.numberOfBubbles);

  @override
  _BubbleAnimationState createState() => _BubbleAnimationState();
}

class _BubbleAnimationState extends State<BubbleAnimation> {
  final Random random = Random();

  final List<ParticleModel> bubbles = [];

  @override
  void initState() {
    List.generate(widget.numberOfBubbles, (index) {
      bubbles.add(ParticleModel(random));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateBubbles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(bubbles, time),
        );
      },
    );
  }

  _simulateBubbles(Duration time) {
    bubbles.forEach((particle) => particle.maintainRestart(time));
  }
}

class ParticleModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 2.2);
    final endPosition = Offset(-0.2 + 1.3 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 16000 + random.nextInt(16000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.02 + random.nextDouble() * 0.03;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> bubbles;
  Duration time;

  ParticlePainter(this.bubbles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(20);

    bubbles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




