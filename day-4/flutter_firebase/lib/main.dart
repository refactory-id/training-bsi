import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/login_page.dart';
import 'package:flutter_firebase/pages/register_page.dart';
import 'package:flutter_firebase/providers/auth_provider.dart';
import 'package:flutter_firebase/providers/home_provider.dart';
import 'package:flutter_firebase/utils/color_util.dart';
import 'package:flutter_firebase/widgets/logo_widget.dart';
import 'package:flutter_firebase/widgets/oops_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final auth = FirebaseAuth.instance;
  final reference = FirebaseFirestore.instance.collection("users");
  final fcmKey =
      "AAAABSjFDJQ:APA91bGSwoX_DiGcwEd-GlckOrARamo8omk-9KYxneIxJ3JeiNE6AVkEDrV_PLwPsyfmfQU8XE3nmh8v3ttJBBA2Ek0enzt9iTNem7aVOFBlP6rbvyfaqG0rVTJoJRFC6B4mzjbO9M79";
  final dio = Dio();

  dio.options.connectTimeout = 60 * 1000;
  dio.options.receiveTimeout = 60 * 1000;
  dio.options.sendTimeout = 60 * 1000;
  dio.options.baseUrl = "https://fcm.googleapis.com/";
  dio.options.headers = {
    "Content-Type": "application/json",
    "Authorization": "key=$fcmKey"
  };

  if (MyApp.isDebug) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
      error: true,
    ));
  }
  final firebaseMessaging = FirebaseMessaging();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => AuthProvider(auth, reference)),
      ChangeNotifierProvider(
          create: (context) =>
              HomeProvider(firebaseMessaging, auth, reference, dio)),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static bool get isDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  static AndroidNotificationChannel get _channel => AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

  static Future<dynamic> handleMessage(Map<String, dynamic> payload) async {
    print("${Platform.isIOS ? 'iOS' : 'Android'}: $payload");

    if (payload.containsKey("data")) {
      final data = payload["data"];
      final sender = data["sender"];
      final message = data["message"];

      FlutterLocalNotificationsPlugin().show(
          message.hashCode,
          "Pesan masuk dari $sender",
          message,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              _channel.description,
            ),
          ),
          payload: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1), () async {
          final flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          final initializationSettingsAndroid =
              AndroidInitializationSettings('@mipmap/ic_launcher');
          final IOSInitializationSettings initializationSettingsIOS =
              IOSInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) async {},
          );
          final MacOSInitializationSettings initializationSettingsMacOS =
              MacOSInitializationSettings();
          final InitializationSettings initializationSettings =
              InitializationSettings(
                  android: initializationSettingsAndroid,
                  iOS: initializationSettingsIOS,
                  macOS: initializationSettingsMacOS);

          flutterLocalNotificationsPlugin.initialize(
            initializationSettings,
            onSelectNotification: (payload) async {
              print(payload);
            },
          );

          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(_channel);

          FirebaseMessaging().configure(
              onMessage: handleMessage,
              onBackgroundMessage: Platform.isAndroid ? handleMessage : null,
              onResume: handleMessage,
              onLaunch: handleMessage);
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return OopsWidget();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                scaffoldBackgroundColor: colorPrimary,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: LoginPage(),
              routes: {
                RegisterPage.route: (_) => RegisterPage(),
                HomePage.route: (_) => HomePage(),
              },
            );
          }

          return LogoWidget();
        });
  }
}
