import 'package:flutter/material.dart';
import './config.dart';

class CustomButtonWithLink extends StatefulWidget {
  final String text;
  final String link;
  final VoidCallback onPress;

  const CustomButtonWithLink({
    Key? key,
    required this.text,
    required this.link,
    required this.onPress,
  }) : super(key: key);

  @override
  _CustomButtonWithLinkState createState() => _CustomButtonWithLinkState();
}

class _CustomButtonWithLinkState extends State<CustomButtonWithLink> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: Constants.edgePaddings,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text, style: Constants.textStyle),
            GestureDetector(
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
                  child:
                      Text("click here", style: Constants.textStyle),
                ),
              ),
            )
          ],
        ));
  }
}
