import 'dart:async';

import 'package:flutter/material.dart';
import './config.dart';
import 'package:speezy/themes/material_color_theme.dart';

class CustomTextField extends StatefulWidget {
  final String placeHolder;
  final bool isPassword;
  final ValueChanged<String>? onChangeText;

  const CustomTextField({
    Key? key,
    required this.placeHolder,
    required this.isPassword,
    required this.onChangeText,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: Constants.edgeMargins,
        child: TextField(
          obscureText: widget.isPassword ? _obscureText : false,
          onChanged: (text) {
            widget.onChangeText!(text);
          },
          style: Constants.textStyle,
          decoration: InputDecoration(
            contentPadding: Constants.edgePaddings,
            hintText: widget.placeHolder,
            border: Constants.textFieldBorderStyle,
            enabledBorder: Constants.textFieldBorderStyle,
            focusedBorder: Constants.textFieldBorderStyle,
            filled: true,
            fillColor: Colors.transparent,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: MaterialColorTheme.light.textColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ));
  }
}
