import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/services/raja_ongkir_service.dart';

class RajaOngkirServiceImpl extends RajaOngkirService {
  final Dio _dio;

  RajaOngkirServiceImpl(this._dio);

  @override
  Future<Response> calculateCost(Map<String, dynamic> body) {
    return _dio.post("cost", data: body);
  }

  @override
  Future<Response> getCitiesByProvince(String id) {
    return _dio.get("city?province=$id");
  }

  @override
  Future<Response> getProvinces() {
    return _dio.get("province");
  }
}
