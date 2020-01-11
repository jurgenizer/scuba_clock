import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {

  static const weatherInfoText = TextStyle(
    color: Color(0xff23bba6),
    fontFamily: 'Quicksand',
    fontSize: 17,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  /// light theme colors
  static const lightBackground = Color(0xff272083);

  static const heliotropePink = Color(0xffd775ec);

  static const azureCyan = Color(0xff5399b5);

  static const tealBlue = Color(0xff35829f);

  static const seaGreen = Color(0xff23bba6);

  /// dark theme colors

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

  /// random colors, transparent etc.

  static const transparentColor = Color(0x00000000);

  static const shadowColor = Color(0xa0000000);

  static const shadowGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [transparentColor, shadowColor],
  );

  static const ColorFilter desaturatedColorFilter =
      // 222222 is a random color that has low color saturation.
      ColorFilter.mode(Color(0xFF222222), BlendMode.saturation);
}