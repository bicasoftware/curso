import 'package:flutter/material.dart';

Color getForegroundColorByLuminance(Color bgColor) {
  assert(bgColor != null);
  return ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
      ? Colors.white
      : Colors.black87;
}
