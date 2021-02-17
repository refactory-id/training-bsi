import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/entities/province_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';

abstract class RajaOngkirRepository {
  Future<List<City>> getCitiesByProvince(String id);
  Future<List<Province>> getProvinces();
  Future<List<Courier>> calculateCost(CalculateCostBody body);
}
