import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/framework/di/di/app_container.dart';
import 'package:flutter_clean_arch/ui/features/delivery/delivery_page.dart';
import 'package:logging/logging.dart';

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    dynamic error = record.error;
    String message = error.toString();
    print(
        '${record.loggerName}: ${record.level.name}: ${record.message} Error: $message');
  });
  Logger.root.info("Logger initialized.");
}

void main() {
  AppContainer.inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static bool get isDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  MyApp() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DeliveryPage(),
    );
  }
}
