import 'package:flutter_clean_arch/data/services/raja_ongkir_service.dart';
import 'package:flutter_clean_arch/domain/entities/province_entity.dart';
import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';
import 'package:flutter_clean_arch/usecase/mappers/city_mapper.dart';
import 'package:flutter_clean_arch/usecase/mappers/courier_mapper.dart';
import 'package:flutter_clean_arch/usecase/mappers/province_mapper.dart';
import 'package:flutter_clean_arch/usecase/repositories/raja_ongkir_repository.dart';

class RajaOngkirRepositoryImpl implements RajaOngkirRepository {
  final CityMapper _cityMapper;
  final ProvinceMapper _provinceMapper;
  final CourierMapper _courierMapper;
  final RajaOngkirService _service;

  RajaOngkirRepositoryImpl(this._service, this._cityMapper,
      this._provinceMapper, this._courierMapper);

  @override
  Future<List<Courier>> calculateCost(CalculateCostBody body) {
    return _service
        .calculateCost(_courierMapper.toRequestBody(body))
        .then((response) => _courierMapper.toDomainList(response.data));
  }

  @override
  Future<List<City>> getCitiesByProvince(String id) {
    return _service
        .getCitiesByProvince(id)
        .then((response) => _cityMapper.toDomainList(response.data));
  }

  @override
  Future<List<Province>> getProvinces() {
    return _service
        .getProvinces()
        .then((response) => _provinceMapper.toDomainList(response.data));
  }
}
