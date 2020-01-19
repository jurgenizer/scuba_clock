import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const weatherInfoText = TextStyle(
    color: Color(0xfff5f5f5),
    //color: Color(0xff23bba6),
    fontFamily: 'Quicksand',
    fontSize: 17,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  /// light colors

  static const azureCyan = Color(0xff5399b5);

  static const tealBlue = Color(0xff35829f);

  static const tealBlueFish = Color(0xff35829f);

  static const seaGreen = Color(0xff23bba6);

  // items, widgets etc.

  static const circleAvatarBackground = Color(0xff37474f);

  static const hourDialWhite = Colors.white12;

  static const minuteDialWhite = Colors.white24;

  static const secondDots = Color(0xff23bba6);

  /// darker colors

  static const darkBackground = Color(0xff272083);

  static const timberwolfWhite = Color(0xffdbdad6);

  static const darkBlue = Color(0xff000388);

  static const deepKoamaru = Color(0xff302768);

  static const middleRedPurple = Color(0xff100844);

  /// bright colors
  static const middleYellowRed = Color(0xffdab378);

  static const sapphireBlue = Color(0xff02629f);

  static const peruMud = Color(0xffcc874c);

  static const lightBrown = Color(0xffb0661b);
}
