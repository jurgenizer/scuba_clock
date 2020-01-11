import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeCircleAvatar extends StatelessWidget {
  final double angleRadians;
  final double radius;
  final Color avatarRingColor;
  final Color avatarColor;
  final String handTime;

  const TimeCircleAvatar({
    @required this.angleRadians,
    @required this.radius,
    @required this.avatarRingColor,
    @required this.avatarColor,
    @required this.handTime,
  })  : assert(angleRadians != null),
        assert(radius != null),
        assert(avatarRingColor != null),
        assert(avatarColor != null),
        assert(handTime != null);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angleRadians * -1,
      child:  CircleAvatar(
        radius: radius,
    backgroundColor: avatarRingColor,
 
   child: CircleAvatar(
        radius: radius - 4,
    backgroundColor: avatarColor,
    
   child: Text(handTime),
  ),
  ),


    );
  }
 


}
