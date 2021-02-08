import 'package:flutter/material.dart';
import 'package:without_dependency_injection/utils/color_util.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function onClick;

  ButtonWidget(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: colorSecondary,
        padding: EdgeInsets.all(12),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: onClick);
  }
}
