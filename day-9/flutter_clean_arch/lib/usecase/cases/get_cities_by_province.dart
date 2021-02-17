import 'dart:async';

import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/get_cities_by_province_use_case.dart';
import 'package:flutter_clean_arch/usecase/repositories/raja_ongkir_repository.dart';

class GetCitiesByProvinceUseCaseImpl extends GetCitiesByProvinceUseCase {
  final RajaOngkirRepository _repository;

  GetCitiesByProvinceUseCaseImpl(this._repository);

  @override
  Future<Stream<List<City>>> buildUseCaseStream(String params) async {
    final controller = StreamController<List<City>>();

    try {
      controller.add((await _repository.getCitiesByProvince(params)));
    } catch (e) {
      controller.addError(e);
    } finally {
      controller.close();
    }

    return controller.stream;
  }
}
