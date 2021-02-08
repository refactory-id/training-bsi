import 'package:dio/dio.dart';
import 'package:flutter_provider/models/city_model.dart';
import 'package:flutter_provider/models/province_model.dart';
import 'package:flutter_provider/models/raja_ongkir_model.dart';

abstract class RajaOngkirRepository {
  Future<List<Province>> getAllProvinces();
  Future<List<City>> getAllCitiesByProvince(String provinceId);
  Future<List<DeliveryCost>> calaculateCost(Map<String, dynamic> body);
}

class RajaOngkirRepositoryImpl implements RajaOngkirRepository {
  final Dio _dio;

  RajaOngkirRepositoryImpl(this._dio);

  @override
  Future<List<DeliveryCost>> calaculateCost(Map<String, dynamic> body) {
    return _dio.post("cost", data: body).then((response) {
      final deliveryCosts = <DeliveryCost>[];
      final json = response.data;
      final rajaOngkir = json["rajaongkir"];
      final results = rajaOngkir["results"];

      if (rajaOngkir != null && results != null) {
        results.forEach((result) {
          deliveryCosts.add(DeliveryCost.fromJson(result));
        });
      }

      return deliveryCosts;
    });
  }

  @override
  Future<List<City>> getAllCitiesByProvince(String provinceId) {
    return _dio.get("city?province=$provinceId").then((response) {
      final cities = <City>[];
      final json = response.data;
      final rajaOngkir = json["rajaongkir"];
      final results = rajaOngkir["results"];

      if (rajaOngkir != null && results != null) {
        results.forEach((result) {
          cities.add(City.fromJson(result));
        });
      }

      return cities;
    });
  }

  @override
  Future<List<Province>> getAllProvinces() {
    return _dio.get("province").then((response) {
      final provinces = <Province>[];
      final json = response.data;
      final rajaOngkir = json["rajaongkir"];
      final results = rajaOngkir["results"];

      if (rajaOngkir != null && results != null) {
        results.forEach((result) {
          provinces.add(Province.fromJson(result));
        });
      }

      return provinces;
    });
  }
}
