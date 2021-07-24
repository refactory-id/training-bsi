import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injector/injector.dart';
import 'package:todo_app/app/services/v1/todo_service.dart';
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
          .add(InterceptorsWrapper(onRequest: (request, handler) async {
        print("###### REQUEST ######");
        print(
            "${request.method.toUpperCase()}: ${request.baseUrl}${request.path}");
        print("HEADERS: \n${request.headers}");
        print("DATA: \n${jsonEncode(request.data)}");
        return handler.next(request);
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

      return dio;
    });

    injector
        .registerDependency<TodoService>(() => TodoServiceImpl(injector.get()));
  }
}
