import 'package:flutter/material.dart';
import 'package:with_dependency_injection/utils/color_util.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;

  TextInputWidget(this._label, this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        style: TextStyle(color: colorPrimary, fontSize: 16),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            labelText: _label,
            labelStyle: TextStyle(color: colorPrimary, fontSize: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorPrimary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
