// Copyright 2019 The Chromium Authors and Jurgen Geitner. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'package:intl/intl.dart';

import 'package:vector_math/vector_math_64.dart' show radians;

import 'animations/background_animation.dart';
import 'animations/container_hand_animation.dart';
import 'animations/dot_animation.dart';
import 'animations/bubble_animation.dart';
import 'animations/fish_animation.dart';
import 'animations/sine_wave_animation.dart';
import 'animations/wave_animation.dart';
import 'animations/submarine_animation.dart';
import 'container_hand.dart';
import 'drawn_hour_dial.dart';
import 'drawn_minute_dial.dart';
import 'styles.dart';
import 'time_circle_avatar.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A scuba-themed analog clock.
///
/// You can do better than this!
class ScubaClock extends StatefulWidget {
  const ScubaClock(this.model);

  final ClockModel model;

  @override
  _ScubaClockState createState() => _ScubaClockState();
}

class _ScubaClockState extends State<ScubaClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';
  Timer _timer;

  var _initialTime = DateTime.now();
  var _initialSecond = 0;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
    _getInitialTime();
  }

  @override
  void didUpdateWidget(ScubaClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _getInitialTime() {
    // This is used to make sure the animated second dots [ContainerHandAnimation()],
    // start at the correct angle, as the default container or drawn second hand would.

    _initialTime = DateTime.now();
    print('The initial time is: $_initialTime');
    _initialSecond = _initialTime.second;
    //_initialSecond = 0; // test value
    // What is the initial second?
    print('The initial second is: $_initialSecond');
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // What is the time?
      // print('The time is now: $_now');

      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].

    /// Get the size of the screen
    // var screenSize = MediaQuery.of(context).size;

    // What is the height (shortest side) of the screen?
    // print('Height (shortest side) of the screen: ${screenSize.shortestSide}');

    final time = DateFormat.Hms().format(DateTime.now());
    final weatherInfo = DefaultTextStyle(
      style: Styles.weatherInfoText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_temperature),
          Text(_temperatureRange),
          Text(_condition),
          Text(_location),
        ],
      ),
    );

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog scuba-themed clock with time $time',
        value: time,
      ),
      child: Container(
        child: Stack(
          children: [
            Positioned.fill(child: BackgroundAnimation()),
            Positioned.fill(child: BubbleAnimation(40)),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WaveAnimation(
                  height: 300,
                  speed: 1.0,
                  offset: pi,
                ),
              ),
            ),


            Positioned( right: 0,       bottom: 0,child: SubmarineAnimation()),

            Positioned.fill(child: SineWaveAnimation(speed: 1.0)),
            Positioned.fill(child: BubbleAnimation(40)),

            Positioned(
              left: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: weatherInfo,
              ),
            ),

            Positioned.fill(
                child:
                    DrawnMinuteDial(color: Styles.minuteDialWhite, size: 1.0)),

            Positioned.fill(
                         child: FishAnimation(10)),

            Positioned.fill(
                child: DrawnHourDial(color: Styles.hourDialWhite, size: 1.0)),

            // Linear minute hand drawn with [Container].
            ContainerHand(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: _now.minute * radiansPerTick,
              child: Transform.translate(
                offset: Offset(0.0, -148.0),
                child: Container(
                  width: 8,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.lime,
                  ),
                ),
              ),
            ),

            // New round minute hand drawn with [Container] and child.
            ContainerHand(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: _now.minute * radiansPerTick,
              child: Transform.translate(
                offset: Offset(0.0, -148.0),
                child: TimeCircleAvatar(
                    angleRadians: _now.minute * radiansPerTick,
                    radius: 19,
                    avatarRingColor: Colors.lime,
                    avatarColor: Colors.blueGrey[800],
                    handTime: '${_now.minute}'),
              ),
            ),

            // Linear hour hand drawn with [Container].
            ContainerHand(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: _now.hour * radiansPerHour +
                  (_now.minute / 60) * radiansPerHour,
              child: Transform.translate(
                offset: Offset(0.0, -80.0),
                child: Container(
                  width: 24,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                ),
              ),
            ),

            // New round hour hand drawn with [Container] and child.
            ContainerHand(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: _now.hour * radiansPerHour +
                  (_now.minute / 60) * radiansPerHour,
              child: Transform.translate(
                offset: Offset(0.0, -80),
                child: TimeCircleAvatar(
                    angleRadians: _now.hour * radiansPerHour +
                        (_now.minute / 60) * radiansPerHour,
                    radius: 24,
                    avatarRingColor: Colors.amber,
                    avatarColor: Colors.blueGrey[800],
                    handTime: '${_now.hour}'),
              ),
            ),
            // Original drawn hand for reference (to check accuracy of second dots)
            // Commented out after visual testing
            // Hand drawn with [CustomPainter].
            /*
            DrawnHand(
              color: customTheme.accentColor,
              thickness: 4,
              size: 1.0,
              angleRadians: _now.second * radiansPerTick,
            ),
            */
            // Second dot hand 1
            ContainerHandAnimation(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: (_initialSecond) * radiansPerTick,
              child: Transform.translate(
                offset: Offset(0.0, -178.0),
                child: Container(
                  width: 24,
                  height: 22,
                  child: DotAnimation(
                    offset: 1.0,
                    speed: 1.0,
                  ),
                ),
              ),
            ),

            // Second dot hand 2
            ContainerHandAnimation(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: (_initialSecond - 1) * radiansPerTick,
              child: Transform.translate(
                offset: Offset(0.0, -178.0),
                child: Container(
                  width: 20,
                  height: 20,
                  child: DotAnimation(
                    offset: 2.0,
                    speed: 1.0,
                  ),
                ),
              ),
            ),

            // Second dot hand 3
            ContainerHandAnimation(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: (_initialSecond - 2) * radiansPerTick,
              child: Transform.translate(
                offset: Offset(0.0, -178.0),
                child: Container(
                  width: 15,
                  height: 18,
                  child: DotAnimation(
                    offset: 3.0,
                    speed: 1.0,
                  ),
                ),
              ),
            ),

            // Second dot hand 4
            ContainerHandAnimation(
              color: Colors.transparent,
              size: 1.0,
              angleRadians: (_initialSecond - 3) * radiansPerTick,
              child: Transform.translate(
                offset: Offset(0.0, -178.0),
                child: Container(
                  width: 15,
                  height: 18,
                  child: DotAnimation(
                    offset: 4.0,
                    speed: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
