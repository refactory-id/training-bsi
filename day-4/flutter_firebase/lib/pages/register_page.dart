import 'package:flutter/material.dart';
import 'package:flutter_firebase/providers/auth_provider.dart';
import 'package:flutter_firebase/widgets/button_widget.dart';
import 'package:flutter_firebase/widgets/scaffold_widget.dart';
import 'package:flutter_firebase/widgets/state_widget.dart';
import 'package:flutter_firebase/widgets/text_input_widget.dart';
import 'package:flutter_firebase/utils/view_util.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static String route = "/register";

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

    final size = MediaQuery.of(context).size;
    return ScaffoldWidget(
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          nameController.text = auth.name;
          emailController.text = auth.email;
          passwordController.text = auth.password;

          return StateWidget(
              state: auth.state,
              success: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputWidget(
                      label: "Nama Lengkap",
                      controller: nameController,
                      inputType: TextInputType.name),
                  TextInputWidget(
                      label: "Email",
                      controller: emailController,
                      inputType: TextInputType.emailAddress),
                  TextInputWidget(
                    label: "Password",
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.all(16),
                    child: ButtonWidget(
                        text: "Register",
                        onClick: () {
                          if (nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            auth.register(
                                nameController.text,
                                emailController.text,
                                passwordController.text, () {
                              Navigator.pop(context);
                            });
                          } else {
                            context.showSnackbar(
                                "Nama Lengkap, email dan password tidak boleh kosong");
                          }
                        }),
                  )
                ],
              ));
        },
      ),
      title: "Halaman Register",
    );
  }
}
