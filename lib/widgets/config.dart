import 'package:flutter/material.dart';
import 'package:speezy/themes/material_color_theme.dart';

class Constants {
  static final EdgeInsets edgePaddings =
      EdgeInsets.symmetric(horizontal: 20, vertical: 15);
  static final EdgeInsets edgeMargins =
      EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static final TextStyle textStyle = TextStyle(
    color: MaterialColorTheme.light.textColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle textStyleLightColor = TextStyle(
    color: MaterialColorTheme.light.backgroundColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final BorderSide textFieldBorderColorWidth =
      BorderSide(color: MaterialColorTheme.light.textColor, width: 3);
  static final BorderRadius borderRadius = BorderRadius.circular(13);
  static final OutlineInputBorder textFieldBorderStyle = OutlineInputBorder(
      borderRadius: Constants.borderRadius,
      borderSide: Constants.textFieldBorderColorWidth);
  static final BoxDecoration buttonBox = BoxDecoration(
    color: MaterialColorTheme.light.menuColor,
    borderRadius: Constants.borderRadius,
  );
}
