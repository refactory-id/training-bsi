import 'package:flutter_clean_architecture/data/persistences/mappers/city_mapper.dart';
import 'package:flutter_clean_architecture/data/persistences/mappers/courier_mapper.dart';
import 'package:flutter_clean_architecture/data/persistences/mappers/province_mapper.dart';
import 'package:flutter_clean_architecture/domain/persistences/mappers/contracts/city_mapper.dart';
import 'package:flutter_clean_architecture/domain/persistences/mappers/contracts/courier_mapper.dart';
import 'package:flutter_clean_architecture/domain/persistences/mappers/contracts/province_mapper.dart';
import 'package:injector/injector.dart';

class MapperModule {
  static void inject(Injector injector) {
    injector.registerSingleton<ProvinceMapper>(() => ProvinceMapperImpl());
    injector.registerSingleton<CityMapper>(() => CityMapperImpl());
    injector.registerSingleton<CourierMapper>(() => CourierMapperImpl());
  }
}
