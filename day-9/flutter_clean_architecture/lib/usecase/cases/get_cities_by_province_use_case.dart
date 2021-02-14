import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/usecase/get_cities_by_province_use_case.dart';
import 'package:flutter_clean_architecture/usecase/repositories/raja_ongkir_repository.dart';

class GetCitiesByProvinceUseCaseImpl implements GetCitiesByProvinceUseCase {
  final RajaOngkirRepository _repository;

  GetCitiesByProvinceUseCaseImpl(this._repository);

  @override
  Future<List<City>> call(String id) {
    return _repository.getCitiesByProvince(id);
  }
}
