import 'package:flutter/material.dart';

extension ColorConvertion on Color {
  MaterialColor getSwatch() {
    final List<double> strenths = <double>[0.05];
    final Map<int, Color> swatch = {};
    final int r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strenths.add(0.1 * i);
    }

    for (var strenth in strenths) {
      final ds = 0.5 - strenth;
      swatch[(strenth * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - ds)) * ds).round(),
        b + ((ds < 0 ? b : (255 - ds)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }
}
