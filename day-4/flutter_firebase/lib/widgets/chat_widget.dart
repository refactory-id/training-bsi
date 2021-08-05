import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/providers/home_provider.dart';
import 'package:flutter_firebase/utils/color_util.dart';
import 'package:flutter_firebase/utils/view_util.dart';
import 'package:flutter_firebase/widgets/button_widget.dart';
import 'package:flutter_firebase/widgets/text_input_widget.dart';

class ChatWidget extends StatelessWidget {
  final TextEditingController controller;
  final UserModel user;

  ChatWidget(this.user, this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            user.name ?? '',
            style: TextStyle(color: colorTextPrimary, fontSize: 20),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            user.email ?? '',
            style: TextStyle(color: colorTextSecondary, fontSize: 16),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextInputWidget(
                  label: "Pesan yang akan dikirim",
                  controller: this.controller,
                  inputType: TextInputType.text),
            ),
            ButtonWidget(
                text: "Kirim",
                onClick: () {
                  if (controller.text.length > 2) {
                    HomeProvider.unListen(context).sendMessage(
                        controller.text, user, () => controller.clear());
                  } else {
                    context.showSnackbar(
                        "Pesan tidak boleh kurang dari tiga karakter");
                  }
                }),
            SizedBox(
              width: 16,
            ),
          ],
        )
      ],
    );
  }
}
