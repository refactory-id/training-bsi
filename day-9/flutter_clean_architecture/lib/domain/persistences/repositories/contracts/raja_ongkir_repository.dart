import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';

abstract class RajaOngkirRepository {
  Future<List<City>> getCitiesByProvince(String id);
  Future<List<Province>> getProvinces();
  Future<List<Courier>> calculateCost(Map<String, dynamic> body);
}
