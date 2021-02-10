import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/domain/persistences/repositories/contracts/raja_ongkir_repository.dart';
import 'package:flutter_clean_architecture/domain/usecase/contracts/calculate_cost_use_case.dart';

class CalculateCostUseCaseImpl implements CalculateCostUseCase {
  final RajaOngkirRepository _repository;

  CalculateCostUseCaseImpl(this._repository);

  @override
  Future<List<Courier>> call(Map<String, dynamic> body) {
    return _repository.calculateCost(body);
  }
}
