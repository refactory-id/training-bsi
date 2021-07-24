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
        .add(InterceptorsWrapper(onRequest: (request, handler) async {
      print("###### REQUEST ######");
      print("${request.method.toUpperCase()}: ${request.path}");
      print("HEADERS: \n${request.headers}");
      print("DATA: \n${jsonEncode(request.data)}");
      return handler.next(request);
    }, onResponse: (response, handler) async {
      print("###### RESPONSE ######");
      print(
          "${response.requestOptions.method.toUpperCase()}: ${response.requestOptions.path} -> ${response.statusCode}");
      print("HEADERS: \n${response.headers}");
      print("DATA: \n${jsonEncode(response.data)}");
      return handler.next(response);
    }, onError: (err, handler) async {
      print("###### ERROR ######");
      print("ERROR: ${err.response.data}");
      return handler.next(err);
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
