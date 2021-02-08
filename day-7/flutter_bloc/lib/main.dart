import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery/delivery_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery_cost/delivery_cost_bloc.dart';
import 'package:flutter_bloc_state_management/pages/delivery_page.dart';
import 'package:flutter_bloc_state_management/repositories/raja_ongkir_repository.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('${cubit.runtimeType} $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}

void main() {
  if (MyApp.isDebug) Bloc.observer = SimpleBlocObserver();

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
      print(
          "${options.method.toUpperCase()}: ${options.baseUrl}${options.path}");
      print("HEADERS: \n${options.headers}");
      print("DATA: \n${jsonEncode(options.data)}");
      return options;
    }, onResponse: (Response response) async {
      print("###### RESPONSE ######");
      print(
          "${response.request.method.toUpperCase()}: ${response.request.baseUrl}${response.request.path} -> ${response.statusCode}");
      print("HEADERS: \n${response.headers}");
      print("DATA: \n${jsonEncode(response.data)}");
      return response; // continue
    }, onError: (DioError e) async {
      print("###### ERROR ######");
      print("ERROR: $e");
      return e;
    }));
  }

  final RajaOngkirRepository repository = RajaOngkirRepositoryImpl(dio);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => DeliveryBloc(repository)),
    BlocProvider(create: (_) => DeliveryCostBloc(repository))
  ], child: MyApp()));
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
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DeliveryPage(),
    );
  }
}
