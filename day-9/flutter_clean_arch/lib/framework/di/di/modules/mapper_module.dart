import 'package:flutter_clean_arch/data/mappers/city_mapper.dart';
import 'package:flutter_clean_arch/data/mappers/courier_mapper.dart';
import 'package:flutter_clean_arch/data/mappers/province_mapper.dart';
import 'package:flutter_clean_arch/usecase/mappers/city_mapper.dart';
import 'package:flutter_clean_arch/usecase/mappers/courier_mapper.dart';
import 'package:flutter_clean_arch/usecase/mappers/province_mapper.dart';
import 'package:injector/injector.dart';

class MapperModule {
  static void inject(Injector injector) {
    injector.registerSingleton<ProvinceMapper>(() => ProvinceMapperImpl());
    injector.registerSingleton<CityMapper>(() => CityMapperImpl());
    injector.registerSingleton<CourierMapper>(() => CourierMapperImpl());
  }
}
