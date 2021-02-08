import 'package:dio/dio.dart';
import 'package:without_dependency_injection/main.dart';

enum RequestType { GET, POST, PUT, PATCH, DELETE }

abstract class ApiService {
  Future<Map<String, dynamic>> call(String url, RequestType type,
      {Map<String, String> headers, dynamic body, Map<String, String> params});
}

class ApiServiceImpl extends ApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> call(String url, RequestType type,
      {Map<String, String> headers,
      dynamic body,
      Map<String, String> params}) async {
    Response response;

    try {
      switch (type) {
        case RequestType.GET:
          response = await _dio.get(url,
              queryParameters: params,
              options: Options(
                headers: headers,
              ));
          break;
        case RequestType.POST:
          response = await _dio.post(url,
              data: body,
              queryParameters: params,
              options: Options(
                headers: headers,
              ));
          break;
        case RequestType.PUT:
          response = await _dio.put(url,
              data: body,
              queryParameters: params,
              options: Options(
                headers: headers,
              ));
          break;
        case RequestType.PATCH:
          response = await _dio.patch(url,
              data: body,
              queryParameters: params,
              options: Options(
                headers: headers,
              ));
          break;
        case RequestType.DELETE:
          response = await _dio.delete(url,
              queryParameters: params,
              options: Options(
                headers: headers,
              ));
          break;
        default:
          throw Exception("unsupported request type");
      }
    } catch (e) {
      if (MyApp.isDebug) print(e);
    }

    return response.data;
  }
}
