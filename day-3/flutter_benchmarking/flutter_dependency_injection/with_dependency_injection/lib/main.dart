import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_dependency_injection/di/app_component.dart';
import 'package:with_dependency_injection/pages/home_page.dart';
import 'package:with_dependency_injection/pages/todo_page.dart';

void main() {
  AppComponent.init();
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
          final int id = settings.arguments;

          return MaterialPageRoute(builder: (context) => TodoPage(id));
        } else {
          throw Exception("Unsupported route name");
        }
      },
    );
  }
}
