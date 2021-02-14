import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';
import 'package:flutter_clean_architecture/domain/usecase/get_provinces_use_case.dart';
import 'package:flutter_clean_architecture/usecase/repositories/raja_ongkir_repository.dart';

class GetProvinceUseCaseImpl implements GetProvinceUseCase {
  final RajaOngkirRepository _repository;

  GetProvinceUseCaseImpl(this._repository);

  @override
  Future<List<Province>> call() {
    return _repository.getProvinces();
  }
}
