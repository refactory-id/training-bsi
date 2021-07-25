import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EphemeralSwitchWidget extends StatelessWidget {
  final Function(bool) callback;
  final bool isDarkMode;

  EphemeralSwitchWidget({required this.callback, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode ? Colors.black : Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            isDarkMode ? "Mode gelap" : "Mode terang",
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          )),
          CupertinoSwitch(
            value: isDarkMode,
            onChanged: callback,
            activeColor: Colors.white,
            trackColor: Colors.black,
          )
        ],
      ),
    );
  }
}
