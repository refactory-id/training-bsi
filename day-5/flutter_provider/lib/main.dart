import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/pages/delivery_page.dart';
import 'package:flutter_provider/providers/delivery_cost_provider.dart';
import 'package:flutter_provider/providers/delivery_provider.dart';
import 'package:flutter_provider/repositories/raja_ongkir_repository.dart';
import 'package:provider/provider.dart';

void main() {
  final dio = Dio(BaseOptions(
    baseUrl: "https://api.rajaongkir.com/starter/",
    connectTimeout: 30 * 1000,
    receiveTimeout: 30 * 1000,
    sendTimeout: 30 * 1000,
  ));

  dio.options.headers["key"] = "d4bb9252bfe68b20fecb0846e4d7754f";

  if (MyApp.isDebug) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("###### REQUEST ######");
      print("${options.method.toUpperCase()}: ${options.path}");
      print("HEADERS: \n${options.headers}");
      print("DATA: \n${jsonEncode(options.data)}");
      return options;
    }, onResponse: (Response response) async {
      print("###### RESPONSE ######");
      print(
          "${response.request.method.toUpperCase()}: ${response.request.path} -> ${response.statusCode}");
      print("HEADERS: \n${response.headers}");
      print("DATA: \n${jsonEncode(response.data)}");
      return response; // continue
    }, onError: (DioError e) async {
      print("###### ERROR ######");
      print("ERROR: ${e.response.data}");
      return e;
    }));
  }

  final RajaOngkirRepository repository = RajaOngkirRepositoryImpl(dio);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DeliveryProvider(repository)),
      ChangeNotifierProvider(create: (_) => DeliveryCostProvider(repository)),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shipping Carges',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DeliveryPage(),
    );
  }
}
