import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:without_dependency_injection/pages/home_page.dart';
import 'package:without_dependency_injection/pages/todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static bool get isDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == TodoPage.route) {
          final id = settings.arguments as int;

          return MaterialPageRoute(builder: (context) => TodoPage(id));
        } else {
          throw Exception("Unsupported route name");
        }
      },
    );
  }
}
