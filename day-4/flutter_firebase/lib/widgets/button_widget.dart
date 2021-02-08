import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/color_util.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function onClick;
  final Color color;

  ButtonWidget({@required this.text, @required this.onClick, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: color ?? colorAccent,
        padding: EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onPressed: onClick);
  }
}
