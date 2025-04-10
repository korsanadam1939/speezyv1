import 'package:flutter/material.dart';
import 'package:speezy/widgets/custom_button.dart';
import 'package:speezy/widgets/custom_button_with_link.dart';
import 'package:speezy/widgets/custom_text_field.dart';
import 'package:speezy/widgets/config.dart';

class LogInPage extends StatefulWidget {
  final VoidCallback onLog;
  final VoidCallback goToRegisterPage;
  final ValueChanged<String>? onMail;
  final ValueChanged<String>? onPassword;

  const LogInPage({
    Key? key,
    required this.onLog,
    required this.goToRegisterPage,
    required this.onMail,
    required this.onPassword,
  });

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
                padding: Constants.edgePaddings,
                child: Row(
                  children: [
                    Text(
                      "or sign ip with email",
                      style: Constants.textStyle,
                    ),
                    Expanded(child: Container())
                  ],
                )),
            CustomTextField(
                placeHolder: "email",
                isPassword: false,
                onChangeText: widget.onMail),
            CustomTextField(
                placeHolder: "password",
                isPassword: true,
                onChangeText: widget.onPassword),
            CustomButton(text: "LOG IN", onPress: widget.onLog),
            CustomButtonWithLink(
                text: "dont have an account",
                link: "click here!",
                onPress: widget.goToRegisterPage)
          ],
        ));
  }
}
