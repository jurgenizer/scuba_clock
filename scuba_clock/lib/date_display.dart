import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:scuba_clock/animations/diver_animation.dart';

class DateDisplay extends StatelessWidget {
  final int weekdayValue;
  final int dayValue;


  const DateDisplay({
 
    @required this.weekdayValue,
    @required this.dayValue,
  })  : assert(weekdayValue != null),
        assert(dayValue != null);
   
     

  @override
  Widget build(BuildContext context) {
    Widget myChild;

    /// Get the size of the screen
    var screenSize = MediaQuery.of(context).size;

    print('The day of the week is: $weekdayValue');

    final yOffset = ((screenSize.shortestSide * weekdayValue / -8) + 40);
    print('The day of the week is: $weekdayValue');

    switch (weekdayValue) {
      // Using ISO 8601 convention, week starts on Monday
      case 1:
        print('Monday');
        myChild = Transform.translate(
          offset: new Offset(0.0, yOffset),
          child: new Row(
            children: <Widget>[
              DiverAnimation(),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Styles.circleAvatarBackground,
                  child: Text(dayValue.toStringAsFixed(0)),
                ),
                label: Text('Mon'),
              ),
            ],
          ),
        );
        break;
      case 2:
        print('Tuesday');
        myChild = Transform.translate(
          offset: new Offset(0.0, yOffset),
          child: new Row(
            children: <Widget>[
             DiverAnimation(),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Styles.circleAvatarBackground,
                  child: Text(dayValue.toStringAsFixed(0)),
                ),
                label: Text('Tue'),
              ),
            ],
          ),
        );
        break;
      case 3:
        print('Wednesday');
        myChild = myChild = Transform.translate(
          offset: new Offset(0.0, yOffset),
          child: new Row(
            children: <Widget>[
               DiverAnimation(),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Styles.circleAvatarBackground,
                  child: Text(dayValue.toStringAsFixed(0)),
                ),
                label: Text('Wed'),
              ),
            ],
          ),
        );
        break;
      case 4:
        print('Thursday');
        myChild = myChild = Transform.translate(
          offset: new Offset(0.0, yOffset),
          child: new Row(
            children: <Widget>[
             DiverAnimation(),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Styles.circleAvatarBackground,
                  child: Text(dayValue.toStringAsFixed(0)),
                ),
                label: Text('Thu'),
              ),
            ],
          ),
        );
        break;
      case 5:
        print('Friday');
        myChild = myChild = Transform.translate(
          offset: new Offset(0.0, yOffset),
          child: new Row(
            children: <Widget>[
              DiverAnimation(),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Styles.circleAvatarBackground,
                  child: Text(dayValue.toStringAsFixed(0)),
                ),
                label: Text('Fri'),
              ),
            ],
          ),
        );
        break;
      case 6:
        print('Saturday');
        myChild = myChild = Transform.translate(
          offset: new Offset(0.0, yOffset),
          child: new Row(
            children: <Widget>[
              DiverAnimation(),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Styles.circleAvatarBackground,
                  child: Text(dayValue.toStringAsFixed(0)),
                ),
                label: Text('Sat'),
              ),
            ],
          ),
        );
        break;
      case 7:
        print('Sunday');
        myChild = Transform.translate(
          offset: new Offset(0.0, yOffset),
          child: new Row(
            children: <Widget>[
              DiverAnimation(),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Styles.circleAvatarBackground,
                  child: Text(dayValue.toStringAsFixed(0)),
                ),
                label: Text('Sun'),
              ),
            ],
          ),
        );
        break;

      default:
        print('Unknown day');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text('?'),
          ),
          label: Text('Someday'),
        );
    }

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
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
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
