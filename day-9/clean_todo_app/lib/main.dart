import 'package:clean_todo_app/app/di/app_container.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  AppContainer.inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    initLogger();
  }

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

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    dynamic e = record.error;
    String m = e is DioError ? e.message : e.toString();
    print(
        '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
  });
  Logger.root.info("Logger initialized.");
}
