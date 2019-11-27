import 'package:flutter/material.dart';

Color getForegroundColorByLuminance(Color bgColor) {
  assert(bgColor != null);
  return ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
      ? Colors.white
      : Colors.black87;
}

bool parseBool<T>(T value) {
  if (value is String) {
    if (value == "0" || value == "false" || value == "f") {
      return false;
    } else if (value == "1" || value == "true" || value == "t") {
      return true;
    } else {
      return null;
    }
  } else if (value is int || value is double) {
    if (value == 0) {
      return false;
    } else if (value == 1) {
      return true;
    } else {
      return null;
    }
  } else {
    return null;
  }
}

bool intToBool(int value) => value == 1;

int boolToInt(bool value) => value == true ? 1 : 0;

int strToInt(String color) => int.tryParse(color) ?? Colors.grey.value;




