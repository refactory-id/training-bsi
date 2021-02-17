import 'dart:convert';
import 'package:dio/dio.dart';

class InterceptorLogger extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    print("###### REQUEST ######");
    print("${options.method.toUpperCase()}: ${options.baseUrl}${options.path}");
    print("HEADERS: \n${options.headers}");
    print("DATA: \n${jsonEncode(options.data)}");
    return options;
  }

  @override
  Future onResponse(Response response) async {
    print("###### RESPONSE ######");
    print(
        "${response.request.method.toUpperCase()}: ${response.request.baseUrl}${response.request.path} -> ${response.statusCode}");
    print("HEADERS: \n${response.headers}");
    print("DATA: \n${jsonEncode(response.data)}");
    return response;
  }

  @override
  Future onError(DioError e) async {
    print("###### ERROR ######");
    print("ERROR: $e");
    return e;
  }
}
