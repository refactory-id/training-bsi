import 'package:flutter/material.dart';
import 'package:flutter_encrypt_local_storage/utils/color_util.dart';

class ScaffoldWidget extends Scaffold {
  final String title;
  final Widget body;
  final FloatingActionButton floatingActionButton;

  ScaffoldWidget(
      {this.title = "", @required this.body, this.floatingActionButton})
      : super(
            body: body,
            backgroundColor: colorPrimary,
            floatingActionButton: floatingActionButton,
            appBar: AppBar(
                brightness: Brightness.dark,
                title: Text(
                  title,
                  style: TextStyle(color: colorTextPrimary),
                ),
                backgroundColor: colorPrimary,
                elevation: 0,
                centerTitle: true));
}
