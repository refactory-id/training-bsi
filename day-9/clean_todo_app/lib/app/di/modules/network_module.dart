import 'dart:convert';

import 'package:clean_todo_app/app/services/v1/todo_service.dart';
import 'package:clean_todo_app/data/services/todo_service.dart';
import 'package:dio/dio.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static inject(Injector injector) {
    injector.registerDependency<Dio>(() {
      final dio = Dio(BaseOptions(
        baseUrl: "https://online-course-todo.herokuapp.com/api/",
        connectTimeout: 30 * 1000,
        receiveTimeout: 30 * 1000,
        sendTimeout: 30 * 1000,
      ));

      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        print("###### REQUEST ######");
        print(
            "${options.method.toUpperCase()}: ${options.baseUrl}${options.path}");
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
      }, onError: (error, hanlder) async {
        print("###### ERROR ######");
        print("ERROR: $error");
        return hanlder.next(error);
      }));

      return dio;
    });

    injector
        .registerDependency<TodoService>(() => TodoServiceImpl(injector.get()));
  }
}
