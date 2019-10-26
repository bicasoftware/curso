import 'package:flutter/material.dart';

class TextThemes {
  static TextStyle label(BuildContext c) {
    final theme = Theme.of(c);
    return theme.textTheme.button.copyWith(color: theme.accentColor);
  }
}