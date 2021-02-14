import 'package:dio/dio.dart';

abstract class RajaOngkirService {
  Future<Response> getCitiesByProvince(String id);
  Future<Response> getProvinces();
  Future<Response> calculateCost(Map<String, dynamic> body);
}
