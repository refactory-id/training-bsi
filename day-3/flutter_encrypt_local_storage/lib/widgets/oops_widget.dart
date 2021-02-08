import 'package:flutter/material.dart';
import 'package:flutter_encrypt_local_storage/utils/color_util.dart';
import 'package:flutter_svg/svg.dart';

class OopsWidget extends StatelessWidget {
  final String message;

  OopsWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width / 8)),
          child: SvgPicture.asset("images/error.svg"),
        ),
        Text(
          message ?? "Oops something went wrong",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorTextPrimary),
        )
      ],
    );
  }
}
