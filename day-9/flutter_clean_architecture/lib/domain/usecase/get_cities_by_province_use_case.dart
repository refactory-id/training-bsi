import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';

abstract class GetCitiesByProvinceUseCase {
  Future<List<City>> call(String id);
}
