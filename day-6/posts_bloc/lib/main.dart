import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/bloc/post/post_bloc.dart';
import 'package:posts_bloc/page/post_page.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();

  final dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com/",
    connectTimeout: 30 * 1000,
    receiveTimeout: 30 * 1000,
    sendTimeout: 30 * 1000,
  ));

  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    print("###### REQUEST ######");
    print("${options.method.toUpperCase()}: ${options.baseUrl}${options.path}");
    print("HEADERS: \n${options.headers}");
    print("DATA: \n${jsonEncode(options.data)}");
    return handler.next(options);
  }, onResponse: (response, handler) async {
    print("###### RESPONSE ######");
    print(
        "${response.requestOptions.method.toUpperCase()}: ${response.requestOptions.baseUrl}${response.requestOptions.path} -> ${response.statusCode}");
    print("HEADERS: \n${response.headers}");
    print("DATA: \n${jsonEncode(response.data)}");
    return handler.next(response);
  }, onError: (err, handler) async {
    print("###### ERROR ######");
    print("ERROR: $err");
    return handler.next(err);
  }));

  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => PostBloc(dio))], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PostPage(),
    );
  }
}
