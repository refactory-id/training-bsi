import 'package:flutter/material.dart';

import 'color_util.dart';

extension ViewUtil on BuildContext {
  void showSnackbar(String message) {
    Scaffold.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
            fontSize: 16, color: colorDanger, fontWeight: FontWeight.w500),
      ),
      backgroundColor: colorSnackbar,
    ));
  }
}
