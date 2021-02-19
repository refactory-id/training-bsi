import 'package:clean_todo_app/app/di/app_container.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_page.dart';
import 'package:flutter/material.dart';

void main() {
  AppContainer.inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodosPage(),
    );
  }
}
