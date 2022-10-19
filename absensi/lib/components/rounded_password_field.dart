import 'package:absensi/constant.dart';
import 'package:flutter/material.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  const RoundedPasswordField(
      {Key? key, required this.onChanged, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kSecondColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kSecondColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kSecondColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
