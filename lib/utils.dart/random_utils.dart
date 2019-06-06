import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

Color getForegroundColorByLuminance({@required Color bgColor}) {
  return (bgColor != null && bgColor.computeLuminance() < 0.5) ? Colors.white : Colors.black;
}