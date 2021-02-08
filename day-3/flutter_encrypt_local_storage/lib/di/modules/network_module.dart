import 'package:dio/dio.dart';
import 'package:flutter_encrypt_local_storage/main.dart';
import 'package:flutter_encrypt_local_storage/services/api_service.dart';
import 'package:flutter_encrypt_local_storage/services/auth_service.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static void init(Injector injector) {
    injector.registerSingleton<Dio>(() {
      final baseUrl = "https://phone-book-api.herokuapp.com/api/";
      final dio = Dio();

      dio.options.connectTimeout = 60 * 1000;
      dio.options.receiveTimeout = 60 * 1000;
      dio.options.sendTimeout = 60 * 1000;
      dio.options.baseUrl = baseUrl;

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

      return dio;
    });

    injector.registerSingleton<ApiService>(
        () => ApiServiceImpl(injector.get<Dio>()));

    injector.registerSingleton<AuthService>(
        () => AuthServiceImpl(injector.get<ApiService>()));
  }
}
