import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final double padding;
  final int minLines, maxLines;
  final TextInputType inputType;
  final Function(String) onChanged;

  const TextInputWidget(
      {Key key,
      @required this.label,
      @required this.controller,
      @required this.inputType,
      this.padding = 16,
      this.isPassword = false,
      this.minLines = 1,
      this.maxLines = 1,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(padding),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontSize: 16),
        obscureText: isPassword,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: inputType ?? TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            labelText: label,
            labelStyle: TextStyle(color: Colors.black87, fontSize: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
