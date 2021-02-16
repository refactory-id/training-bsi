import 'package:flutter/material.dart';

class DropdownMenuItemWidget<T> extends DropdownMenuItem<T> {
  DropdownMenuItemWidget(
      {Key key,
      @required String text,
      @required T value,
      @required BuildContext context})
      : super(
            key: key,
            value: value,
            child: Container(
                width: (MediaQuery.of(context).size.width - 56),
                child: Text(text)));
}
