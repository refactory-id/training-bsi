import 'package:flutter_clean_architecture/data/mappers/city_mapper.dart';
import 'package:flutter_clean_architecture/data/mappers/courier_mapper.dart';
import 'package:flutter_clean_architecture/data/mappers/province_mapper.dart';
import 'package:flutter_clean_architecture/usecase/mappers/city_mapper.dart';
import 'package:flutter_clean_architecture/usecase/mappers/courier_mapper.dart';
import 'package:flutter_clean_architecture/usecase/mappers/province_mapper.dart';
import 'package:injector/injector.dart';

class MapperModule {
  static void inject(Injector injector) {
    injector.registerSingleton<ProvinceMapper>(() => ProvinceMapperImpl());
    injector.registerSingleton<CityMapper>(() => CityMapperImpl());
    injector.registerSingleton<CourierMapper>(() => CourierMapperImpl());
  }
}
