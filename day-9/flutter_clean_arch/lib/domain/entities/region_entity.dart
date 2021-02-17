import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/entities/province_entity.dart';

class Region {
  final List<Province> provinces;
  final List<City> cities;

  Region({this.provinces, this.cities});
}
