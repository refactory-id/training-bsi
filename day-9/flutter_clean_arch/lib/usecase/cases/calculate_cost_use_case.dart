import 'dart:async';

import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';
import 'package:flutter_clean_arch/usecase/repositories/raja_ongkir_repository.dart';

class CalculateCostUseCaseImpl extends CalculateCostUseCase {
  final RajaOngkirRepository _repository;

  CalculateCostUseCaseImpl(this._repository);

  @override
  Future<Stream<List<Courier>>> buildUseCaseStream(
      List<CalculateCostBody> params) async {
    final controller = StreamController<List<Courier>>();

    try {
      final couriers = await Future.wait(params.map<Future<Courier>>((param) =>
          _repository.calculateCost(param).then((value) => value.first)));

      controller.add(couriers);
    } catch (e) {
      controller.addError(e);
    } finally {
      controller.close();
    }

    return controller.stream;
  }
}

class CalculateCostBodyImpl implements CalculateCostBody {
  @override
  String courier;
  @override
  String destination;
  @override
  String origin;
  @override
  int weight;

  CalculateCostBodyImpl(
      {this.weight, this.courier, this.destination, this.origin});

  @override
  CalculateCostBody copyWith(
      {int weight, String origin, String destination, String courier}) {
    return CalculateCostBodyImpl(
      weight: weight ?? this.weight,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      courier: courier ?? this.courier,
    );
  }
}
