import 'package:flutter_clean_arch/domain/entities/city_entity.dart';

abstract class CityMapper {
  List<City> toDomainList(dynamic response);
}
