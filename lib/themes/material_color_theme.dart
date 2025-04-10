import 'package:flutter/material.dart';

class LightTheme {
  final Color backgroundColor;
  final Color menuColor;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final Brightness brightness;

  const LightTheme({
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.menuColor = const Color.fromARGB(255, 255, 168, 111),
    this.buttonColor = const Color.fromARGB(255, 255, 137, 58),
    this.textColor = const Color(0x80000000),
    this.iconColor = const Color(0xFF000000),
    this.brightness = Brightness.light,
  });
}

class DarkTheme {
  final Color backgroundColor;
  final Color menuColor;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final Brightness brightness;

  const DarkTheme({
    this.backgroundColor = const Color(0xFF121212), // Better than pure black
    this.menuColor = const Color.fromARGB(255, 255, 152, 83),
    this.buttonColor = const Color.fromARGB(255, 255, 183, 135),
    this.textColor = const Color(0xB3FFFFFF), // Better visibility
    this.iconColor = const Color(0xFFFFFFFF),
    this.brightness = Brightness.dark,
  });
}

class MaterialColorTheme {
  static const LightTheme light = LightTheme();
  static const DarkTheme dark = DarkTheme();
}
