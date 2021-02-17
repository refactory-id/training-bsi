import 'dart:async';

import 'package:flutter_clean_arch/domain/entities/province_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/get_provinces_use_case.dart';
import 'package:flutter_clean_arch/usecase/repositories/raja_ongkir_repository.dart';

class GetProvincesUseCaseImpl extends GetProvinceUseCase {
  final RajaOngkirRepository _repository;

  GetProvincesUseCaseImpl(this._repository);

  @override
  Future<Stream<List<Province>>> buildUseCaseStream(void params) async {
    final controller = StreamController<List<Province>>();

    try {
      controller.add((await _repository.getProvinces()));
    } catch (e) {
      controller.addError(e);
    } finally {
      controller.close();
    }

    return controller.stream;
  }
}
