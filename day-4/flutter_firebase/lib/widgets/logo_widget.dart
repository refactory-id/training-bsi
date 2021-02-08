import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/color_util.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              textDirection: TextDirection.ltr,
              text: TextSpan(
                  text: "Flutter",
                  style: TextStyle(
                      color: Color(0xff39CEFD),
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: "Firebase",
                        style: TextStyle(
                            color: Color(0xffFFA001),
                            fontSize: 24,
                            fontWeight: FontWeight.w500))
                  ])),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
            ),
          )
        ],
      ),
    );
  }
}
