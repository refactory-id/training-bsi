import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/color_util.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final Function(String) onChange;
  final TextInputType inputType;

  TextInputWidget(
      {@required this.label,
      @required this.controller,
      @required this.inputType,
      this.onChange,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        style: TextStyle(color: colorTextSecondary, fontSize: 16),
        obscureText: isPassword,
        onChanged: onChange,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            labelText: label,
            labelStyle: TextStyle(color: colorTextPrimary, fontSize: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
