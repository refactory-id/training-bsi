import 'package:flutter/material.dart';
import 'package:flutter_encrypt_local_storage/utils/color_util.dart';
import 'package:flutter_encrypt_local_storage/utils/string_util.dart';
import 'package:flutter_encrypt_local_storage/widgets/scaffold_widget.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  static String route = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<dynamic> box;
  String rawName = "";
  String name = "";
  String rawEmail = "";
  String email = "";
  String rawToken = "";
  String token = "";

  @override
  void didChangeDependencies() {
    box = Hive.box("flutter_encrypt_local_storage");

    rawName = box.get("name", defaultValue: "");
    name = decode(box.get("name", defaultValue: ""));
    rawEmail = box.get("email", defaultValue: "");
    email = decode(box.get("email", defaultValue: ""));
    rawToken = box.get("token", defaultValue: "");
    token = decode(box.get("token", defaultValue: ""));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        box.clear();
        Navigator.pop(context);

        return true;
      },
      child: ScaffoldWidget(
          title: "Halaman Home",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              textWidget("Encrypted name: $rawName"),
              textWidget("Decrypted name: $name"),
              SizedBox(
                height: 32,
              ),
              textWidget("Encrypted email: $rawEmail"),
              textWidget("Decrypted email: $email"),
              SizedBox(
                height: 32,
              ),
              textWidget("Encrypted token: $rawToken"),
              textWidget("Decrypted token: $token")
            ],
          )),
    );
  }

  Widget textWidget(String text) => Container(
        margin: EdgeInsets.all(8),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: colorTextSecondary),
        ),
      );
}
