import 'package:flutter/material.dart';
import 'package:speezy/widgets/custom_button.dart';
import 'package:speezy/widgets/custom_button_with_link.dart';
import 'package:speezy/widgets/custom_text_field.dart';
import 'package:speezy/widgets/config.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onLog;
  final VoidCallback goToLoginPage;
  final ValueChanged<String>? onUserName;
  final ValueChanged<String>? onMail;
  final ValueChanged<String>? onPassword;
  final ValueChanged<String>? onRepeatPassword;

  const RegisterPage({
    Key? key,
    required this.onLog,
    required this.goToLoginPage,
    required this.onUserName,
    required this.onMail,
    required this.onPassword,
    required this.onRepeatPassword,
  });

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                      "or sign up with email",
                      style: Constants.textStyle,
                    ),
                    Expanded(child: Container())
                  ],
                )),
            CustomTextField(
                placeHolder: "username",
                isPassword: false,
                onChangeText: widget.onUserName),
            CustomTextField(
                placeHolder: "email",
                isPassword: false,
                onChangeText: widget.onMail),
            CustomTextField(
                placeHolder: "password",
                isPassword: true,
                onChangeText: widget.onPassword),
            CustomTextField(
                placeHolder: "repeat password",
                isPassword: true,
                onChangeText: widget.onRepeatPassword),
            CustomButton(text: "CREATE ACCOUNT", onPress: widget.onLog),
            CustomButtonWithLink(
                text: "allready have an account",
                link: "click here!",
                onPress: widget.goToLoginPage)
          ],
        ));
  }
}
