import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/persistences/repositories/contracts/raja_ongkir_repository.dart';
import 'package:flutter_clean_architecture/domain/usecase/contracts/get_cities_by_province_use_case.dart';

class GetCitiesByProvinceUseCaseImpl implements GetCitiesByProvinceUseCase {
  final RajaOngkirRepository _repository;

  GetCitiesByProvinceUseCaseImpl(this._repository);

  @override
  Future<List<City>> call(String id) {
    return _repository.getCitiesByProvince(id);
  }
}
