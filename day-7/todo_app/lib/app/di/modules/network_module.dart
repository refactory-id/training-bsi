import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injector/injector.dart';
import 'package:todo_app/app/services/todo_service.dart';
import 'package:todo_app/data/services/todo_service.dart';

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

      return dio;
    });

    injector
        .registerDependency<TodoService>(() => TodoServiceImpl(injector.get()));
  }
}
