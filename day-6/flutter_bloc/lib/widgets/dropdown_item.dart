import 'package:flutter/material.dart';

class DropdownMenuItemWidget<T> extends DropdownMenuItem<T> {
  DropdownMenuItemWidget(
      {Key key,
      @required String text,
      @required T value,
      @required double width})
      : super(
            key: key,
            value: value,
            child: Container(width: width, child: Text(text)));
}
