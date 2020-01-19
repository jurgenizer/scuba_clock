import 'package:flutter/material.dart';
import 'styles.dart';

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

    final startPointX = screenSize.longestSide;
    final startPointY = screenSize.shortestSide / 2 - 120;

    print('The day of the week is: $weekdayValue');

    switch (weekdayValue) {
      // Using ISO 8601 convention, week starts on Monday
      case 1:
        print('Monday');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text(dayValue.toStringAsFixed(0)),
          ),
          label: Text('Monday'),
        );
        break;
      case 2:
        print('Tuesday');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text(dayValue.toStringAsFixed(0)),
          ),
          label: Text('Tuesday'),
        );
        break;
      case 3:
        print('Wednesday');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text(dayValue.toStringAsFixed(0)),
          ),
          label: Text('Wednesday'),
        );
        break;
      case 4:
        print('Thursday');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text(dayValue.toStringAsFixed(0)),
          ),
          label: Text('Thursday'),
        );
        break;
      case 5:
        print('Friday');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text(dayValue.toStringAsFixed(0)),
          ),
          label: Text('Friday'),
        );
        break;
      case 6:
        print('Saturday');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text(dayValue.toStringAsFixed(0)),
          ),
          label: Text('Saturday'),
        );
        break;
      case 7:
        print('Sunday');
        myChild = Chip(
          avatar: CircleAvatar(
            backgroundColor: Styles.circleAvatarBackground,
            child: Text(dayValue.toStringAsFixed(0)),
          ),
          label: Text('Sunday'),
        );
        break;

      default:
        print('Unknown day');
        print('Sunday');
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
