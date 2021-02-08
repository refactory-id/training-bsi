import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_encrypt_local_storage/pages/home_page.dart';
import 'package:flutter_encrypt_local_storage/providers/auth_provider.dart';
import 'package:flutter_encrypt_local_storage/utils/color_util.dart';
import 'package:flutter_encrypt_local_storage/widgets/button_widget.dart';
import 'package:flutter_encrypt_local_storage/widgets/scaffold_widget.dart';
import 'package:flutter_encrypt_local_storage/widgets/state_widget.dart';
import 'package:flutter_encrypt_local_storage/widgets/text_input_widget.dart';
import 'package:flutter_encrypt_local_storage/utils/view_util.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String route = "/";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box("flutter_encrypt_local_storage");
    final String token = box.get("token", defaultValue: "");
    final size = MediaQuery.of(context).size;
    final widget = ScaffoldWidget(
      title: "Halaman login",
      body: Consumer<AuthProvider>(
          builder: (context, provider, child) => StateWidget(
              state: provider.state,
              success: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputWidget(
                    label: "Email",
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                  ),
                  TextInputWidget(
                    label: "Password",
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    child: ButtonWidget(
                      text: "Login",
                      onClick: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          provider.login(
                              emailController.text, passwordController.text,
                              () async {
                            await Navigator.pushNamed(context, HomePage.route);
                          });
                        } else {
                          context.showSnackbar(
                              "Email dan password tidak boleh kosong!");
                        }
                      },
                      color: colorAccent,
                    ),
                  ),
                ],
              ))),
    );
    return token.isNotEmpty
        ? FutureBuilder(
            future: Future.delayed(Duration(seconds: 1),
                () async => Navigator.pushNamed(context, HomePage.route)),
            builder: (context, snapshot) =>
                snapshot.connectionState != ConnectionState.done
                    ? Container(
                        width: size.width,
                        height: size.height,
                        color: colorPrimary,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : widget)
        : widget;
  }
}
