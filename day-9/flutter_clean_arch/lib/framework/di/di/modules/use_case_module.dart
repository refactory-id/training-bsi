import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';
import 'package:flutter_clean_arch/domain/usecases/get_cities_by_province_use_case.dart';
import 'package:flutter_clean_arch/domain/usecases/get_provinces_use_case.dart';
import 'package:flutter_clean_arch/usecase/cases/calculate_cost_use_case.dart';
import 'package:flutter_clean_arch/usecase/cases/get_cities_by_province.dart';
import 'package:flutter_clean_arch/usecase/cases/get_provinces_use_case.dart';
import 'package:injector/injector.dart';

class UseCaseModule {
  static void inject(Injector injector) {
    injector.registerDependency<GetCitiesByProvinceUseCase>(
        () => GetCitiesByProvinceUseCaseImpl(injector.get()));
    injector.registerDependency<CalculateCostUseCase>(
        () => CalculateCostUseCaseImpl(injector.get()));
    injector.registerDependency<GetProvinceUseCase>(
        () => GetProvincesUseCaseImpl(injector.get()));
  }
}
