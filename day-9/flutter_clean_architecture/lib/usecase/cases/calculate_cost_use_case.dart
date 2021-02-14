import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/domain/usecase/calculate_cost_use_case.dart';
import 'package:flutter_clean_architecture/usecase/repositories/raja_ongkir_repository.dart';

class CalculateCostUseCaseImpl implements CalculateCostUseCase {
  final RajaOngkirRepository _repository;

  CalculateCostUseCaseImpl(this._repository);

  @override
  Future<List<Courier>> call(Map<String, dynamic> body) {
    return _repository.calculateCost(body);
  }
}
