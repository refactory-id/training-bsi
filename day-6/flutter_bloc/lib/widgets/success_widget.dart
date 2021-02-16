import 'package:flutter/material.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 48,
      ),
    );
  }
}
