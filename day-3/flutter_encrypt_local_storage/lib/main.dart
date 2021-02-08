import 'package:flutter/material.dart';
import 'package:flutter_encrypt_local_storage/di/app_component.dart';
import 'package:flutter_encrypt_local_storage/pages/home_page.dart';
import 'package:flutter_encrypt_local_storage/pages/login_page.dart';
import 'package:flutter_encrypt_local_storage/providers/auth_provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  final box = await initHive();

  AppComponent.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => AuthProvider(AppComponent.injector.get(), box)),
    ],
    child: MyApp(),
  ));
}

Future<Box<dynamic>> initHive() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = (await getApplicationDocumentsDirectory()).path;

  Hive.init(path);

  return Hive.openBox("flutter_encrypt_local_storage");
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
      home: LoginPage(),
      routes: {HomePage.route: (_) => HomePage()},
    );
  }
}
