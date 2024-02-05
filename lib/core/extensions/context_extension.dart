import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  // get size
  Size get size => mediaQuery.size;

  // get widths
  double get width => size.width;

  // get height
  double get height => size.height;
}
