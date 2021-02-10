import 'package:flutter_clean_architecture/data/infrastructures/contracts/raja_ongkir_service.dart';
import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/persistences/mappers/contracts/city_mapper.dart';
import 'package:flutter_clean_architecture/domain/persistences/mappers/contracts/courier_mapper.dart';
import 'package:flutter_clean_architecture/domain/persistences/mappers/contracts/province_mapper.dart';
import 'package:flutter_clean_architecture/domain/persistences/repositories/contracts/raja_ongkir_repository.dart';

class RajaOngkirRepositoryImpl implements RajaOngkirRepository {
  final CityMapper _cityMapper;
  final ProvinceMapper _provinceMapper;
  final CourierMapper _courierMapper;
  final RajaOngkirService _service;

  RajaOngkirRepositoryImpl(this._service, this._cityMapper,
      this._provinceMapper, this._courierMapper);

  @override
  Future<List<Courier>> calculateCost(Map<String, dynamic> body) {
    return _service
        .calculateCost(body)
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
