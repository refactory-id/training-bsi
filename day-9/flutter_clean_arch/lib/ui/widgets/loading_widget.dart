import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool iosStyle;

  const LoadingWidget({Key key, this.iosStyle = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: iosStyle
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(
                strokeWidth: 2,
              ),
      ),
    );
  }
}
