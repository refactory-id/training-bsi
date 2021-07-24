import 'dart:convert';
import 'package:dio/dio.dart';

class InterceptorLogger extends Interceptor {
  @override
  Future onRequest(
      RequestOptions request, RequestInterceptorHandler handler) async {
    print("###### REQUEST ######");
    print("${request.method.toUpperCase()}: ${request.baseUrl}${request.path}");
    print("HEADERS: \n${request.headers}");
    print("DATA: \n${jsonEncode(request.data)}");
    return handler.next(request);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print("###### RESPONSE ######");
    print(
        "${response.requestOptions.method.toUpperCase()}: ${response.requestOptions.baseUrl}${response.requestOptions.path} -> ${response.statusCode}");
    print("HEADERS: \n${response.headers}");
    print("DATA: \n${jsonEncode(response.data)}");
    return handler.next(response);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    print("###### ERROR ######");
    print("ERROR: $error");
    return handler.next(error);
  }
}
