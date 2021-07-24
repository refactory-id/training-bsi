import 'package:flutter/material.dart';
import 'package:with_dependency_injection/utils/color_util.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function onClick;

  ButtonWidget(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          primary: colorSecondary,
          padding: EdgeInsets.all(12),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: onClick as void Function()?);
  }
}
