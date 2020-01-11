import 'dart:math';

import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

class FishAnimation extends StatefulWidget {
  final int numberOfFish;

  FishAnimation(this.numberOfFish);

  @override
  _FishAnimationState createState() => _FishAnimationState();
}

class _FishAnimationState extends State<FishAnimation> {
  final Random random = Random();

  final List<ParticleModel> fish = [];

  @override
  void initState() {
    List.generate(widget.numberOfFish, (index) {
      fish.add(ParticleModel(random));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateFish,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(fish, time),
        );
      },
    );
  }

  _simulateFish(Duration time) {
    fish.forEach((particle) => particle.maintainRestart(time));
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
    final startPosition = Offset(2.2, -0.2 + 1.4 * random.nextDouble());
    final endPosition = Offset(-0.2, -0.2 + 1.3 * random.nextDouble());
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
  List<ParticleModel> fish;
  Duration time;

  ParticlePainter(this.fish, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.teal[700];

    fish.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.3 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
