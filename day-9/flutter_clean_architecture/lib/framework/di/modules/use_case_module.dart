import 'package:flutter_clean_architecture/domain/usecase/calculate_cost_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecase/get_cities_by_province_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecase/get_provinces_use_case.dart';
import 'package:flutter_clean_architecture/usecase/cases/calculate_cost_use_case.dart';
import 'package:flutter_clean_architecture/usecase/cases/get_cities_by_province_use_case.dart';
import 'package:flutter_clean_architecture/usecase/cases/get_provinces_use_case.dart';
import 'package:injector/injector.dart';

class UseCaseModule {
  static void inject(Injector injector) {
    injector.registerDependency<GetCitiesByProvinceUseCase>(
        () => GetCitiesByProvinceUseCaseImpl(injector.get()));
    injector.registerDependency<CalculateCostUseCase>(
        () => CalculateCostUseCaseImpl(injector.get()));
    injector.registerDependency<GetProvinceUseCase>(
        () => GetProvinceUseCaseImpl(injector.get()));
  }
}
