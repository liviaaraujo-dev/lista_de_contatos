import 'package:flutter/material.dart';

AppBar appBar = AppBar();

extension SizeExtensions on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight =>
      (MediaQuery.of(this).size.height - appBar.preferredSize.height) -
      MediaQuery.of(this).padding.top;

  double percentWidth(double percent) => screenWidth * percent;
  double percentHeight(double percent) => screenHeight * percent;
}
