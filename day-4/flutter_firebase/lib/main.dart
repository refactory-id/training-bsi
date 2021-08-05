import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

final _channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  'This channel is used for important notifications.',
  importance: Importance.max,
);

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<dynamic> _handleMessage(RemoteMessage remoteMessage) async {
  final payload = remoteMessage.data;
  print("${Platform.isIOS ? 'iOS' : 'Android'}: $payload");

  final sender = payload["sender"];
  final message = payload["message"];

  flutterLocalNotificationsPlugin.show(
      message.hashCode,
      "Pesan masuk dari $sender",
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
            _channel.id, _channel.name, _channel.description,
            icon: '@mipmap/ic_launcher'),
      ),
      payload: message);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final initializationSettingsIOS = IOSInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) async {},
  );

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) async {
      print(payload);
    },
  );

  await Future.wait([
    flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(_channel) ??
        Future(() => {}),
    flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
        Future(() => {}),
  ]);

  if (Platform.isAndroid) _handleMessage(message);

  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

  final firebaseMessaging = FirebaseMessaging.instance;

  runZonedGuarded<Future<void>>(() async {
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
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  static bool get isDebug {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  void initFCM(BuildContext context) async {
    await Future.wait([
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      ),
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      )
    ]);

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp
        .listen((remoteMessage) => _openHomePage(remoteMessage, context));
    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((remoteMessage) => _openHomePage(remoteMessage, context));
  }

  void _openHomePage(RemoteMessage? remoteMessage, BuildContext context) {
    final payload = remoteMessage?.data;
    print(
        "${Platform.isIOS ? 'iOS' : Platform.isAndroid ? 'Android' : ''}: $payload");

    Navigator.pushNamed(context, HomePage.route);
  }

  @override
  Widget build(BuildContext context) {
    initFCM(context);

    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1), () {}),
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
