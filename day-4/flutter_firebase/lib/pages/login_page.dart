import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/register_page.dart';
import 'package:flutter_firebase/providers/auth_provider.dart';
import 'package:flutter_firebase/widgets/button_widget.dart';
import 'package:flutter_firebase/widgets/scaffold_widget.dart';
import 'package:flutter_firebase/widgets/state_widget.dart';
import 'package:flutter_firebase/widgets/text_input_widget.dart';
import 'package:flutter_firebase/utils/view_util.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController, passwordController;

  @override
  void didChangeDependencies() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.didChangeDependencies();
  }

  Future<void> checkSession() async {
    return Future.delayed(Duration(seconds: 1),
        () => Navigator.pushNamed(context, HomePage.route));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScaffoldWidget(
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          emailController.text = auth.email;
          passwordController.text = auth.password;

          return auth.isLogged
              ? FutureBuilder(
                  future: checkSession(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.done
                          ? body(auth, context, size)
                          : Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ))
              : body(auth, context, size);
        },
      ),
      title: "Halaman Login",
    );
  }

  StateWidget body(AuthProvider auth, BuildContext context, Size size) {
    return StateWidget(
        state: auth.state,
        success: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Daftar akun",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.grey[300],
                    splashRadius: 16,
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.route);
                    },
                  )
                ],
              ),
            ),
            TextInputWidget(
                label: "Email",
                controller: emailController,
                onChange: (value) => auth.email = emailController.text,
                inputType: TextInputType.emailAddress),
            TextInputWidget(
              label: "Password",
              controller: passwordController,
              onChange: (value) => auth.password = passwordController.text,
              inputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.all(16),
              child: ButtonWidget(
                  text: "Login",
                  onClick: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      auth.login(
                          emailController.text, passwordController.text, () {});
                    } else {
                      context.showSnackbar(
                          "Email dan password tidak boleh kosong");
                    }
                  }),
            )
          ],
        ));
  }
}
