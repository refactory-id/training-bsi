import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
