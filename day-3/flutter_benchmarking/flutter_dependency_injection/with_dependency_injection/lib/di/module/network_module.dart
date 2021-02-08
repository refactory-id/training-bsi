import 'package:dio/dio.dart';
import 'package:with_dependency_injection/services/api_service.dart';
import 'package:with_dependency_injection/services/todo_service.dart';
import 'package:with_dependency_injection/main.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static void init(Injector injector) {
    injector.registerSingleton<Dio>(() {
      final baseUrl = "https://online-course-todo.herokuapp.com/api/";
      final dio = Dio();

      dio.options.connectTimeout = 60 * 1000;
      dio.options.receiveTimeout = 60 * 1000;
      dio.options.baseUrl = baseUrl;

      dio.interceptors.add(LogInterceptor(
        requestBody: MyApp.isDebug,
        responseBody: MyApp.isDebug,
        requestHeader: MyApp.isDebug,
        responseHeader: MyApp.isDebug,
        request: MyApp.isDebug,
        error: MyApp.isDebug,
      ));

      return dio;
    });

    injector.registerSingleton<ApiService>(
        () => ApiServiceImpl(injector.get<Dio>()));

    injector.registerSingleton<TodoService>(
        () => TodoServiceImpl(injector.get<ApiService>()));
  }
}
