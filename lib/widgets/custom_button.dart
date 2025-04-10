import 'package:flutter/material.dart';
import './config.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPress;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        widget.onPress();
        setState(() => _isPressed = false);
      },
      child: Opacity(
        opacity: _isPressed ? 0.6 : 1.0,
        child: Container(
          margin: Constants.edgeMargins,
          padding: Constants.edgePaddings,
          height: 50,
          decoration: Constants.buttonBox,
          child: Center(
            child: Text(widget.text, style: Constants.textStyleLightColor),
          ),
        ),
      ),
    );
  }
}
