import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/services/raja_ongkir_service.dart';
import 'package:flutter_clean_architecture/framework/services/raja_ongkir_service.dart';
import 'package:flutter_clean_architecture/framework/loggers/interceptor_logger.dart';
import 'package:flutter_clean_architecture/main.dart';
import 'package:injector/injector.dart';

class NetworkModule {
  static void inject(Injector injector) {
    injector.registerDependency<Dio>(() {
      final time = 30 * 1000;

      final dio = Dio(BaseOptions(
        baseUrl: "https://api.rajaongkir.com/starter/",
        connectTimeout: time,
        receiveTimeout: time,
        sendTimeout: time,
      ));

      dio.options.headers["key"] = "d4bb9252bfe68b20fecb0846e4d7754f";

      if (MyApp.isDebug) dio.interceptors.add(InterceptorLogger());

      return dio;
    });

    injector.registerDependency<RajaOngkirService>(
        () => RajaOngkirServiceImpl(injector.get<Dio>()));
  }
}
