import 'package:flutter/material.dart';

class MyColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  static const LightColors light = LightColors();

  static Color primary(BuildContext context) => _getTheme(context).primary;
  static Color secondary(BuildContext context) => _getTheme(context).secondary;
  static Color background(BuildContext context) =>
      _getTheme(context).background;

  static ThemeColors _getTheme(BuildContext context) => light;
}

class LightColors extends ThemeColors {
  const LightColors();

  @override
  Color get primary => const Color.fromARGB(255, 122, 93, 62);

  @override
  Color get secondary => const Color.fromARGB(255, 62, 91, 122);

  @override
  Color get background => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get surface => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get error => const Color.fromARGB(255, 162, 27, 51);

  @override
  Color get textPrimary => const Color.fromARGB(255, 73, 74, 87);
}

// TODO: Implemntar ThemeColors para DarkColors

abstract class ThemeColors {
  const ThemeColors();

  Color get primary;
  Color get secondary;
  Color get background;
  Color get surface;
  Color get error;
  Color get textPrimary;

  Color get success => const Color.fromARGB(255, 31, 108, 33);
  Color get warning => const Color.fromARGB(255, 182, 138, 6);
  Color get info => const Color.fromARGB(255, 22, 103, 168);
  Color get disabled => const Color(0xFF9E9E9E);

  Color get textSecondary => const Color(0xFF616161);
}
