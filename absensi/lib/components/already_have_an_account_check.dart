import 'package:absensi/constant.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function() press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Tidak bisa login ? " : "tidak bisa login ? ",
          style: TextStyle(color: kSecondColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Help" : "Help",
            style: TextStyle(
              color: kSecondColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
