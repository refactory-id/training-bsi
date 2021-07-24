import 'package:flutter/material.dart';

import 'color_util.dart';

extension ViewUtil on BuildContext {
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
            fontSize: 16, color: colorSecondary, fontWeight: FontWeight.w600),
      ),
      backgroundColor: colorBackground,
    ));
  }
}
