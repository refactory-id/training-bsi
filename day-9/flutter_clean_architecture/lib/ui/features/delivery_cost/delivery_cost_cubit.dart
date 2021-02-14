import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/service_entity.dart';
import 'package:flutter_clean_architecture/domain/usecase/calculate_cost_use_case.dart';
import 'package:flutter_clean_architecture/ui/features/delivery_cost/delivery_cost_state.dart';

class DeliveryCostCubit extends Cubit<DeliveryCostState> {
  final CalculateCostUseCase _useCase;

  DeliveryCostCubit(this._useCase) : super(null);

  Future<void> calculateCost(
      String origin, String destination, int weight) async {
    emit(LoadingState());

    try {
      final jne = <String, dynamic>{
        "weight": weight,
        "origin": origin,
        "destination": destination,
        "courier": "jne"
      };

      final tiki = Map.of(jne);
      tiki["courier"] = "tiki";

      final pos = Map.of(jne);
      pos["courier"] = "pos";

      final couriers = await Future.wait(
              [_useCase.call(jne), _useCase.call(tiki), _useCase.call(pos)])
          .then((value) => value.map<Courier>((e) => e.first).toList());

      final selectedCourier = couriers.first;
      final services = selectedCourier.services;
      final selectedService = services.isNotEmpty ? services.first : null;

      emit(SuccessState(
          couriers: couriers,
          selectedCourier: selectedCourier,
          services: services,
          selectedService: selectedService));
    } catch (e) {
      if (e is DioError) {
        final message = e.response.data["rajaongkir"]["status"]["description"];

        emit(ErrorState(message));
      } else
        emit(ErrorState(e.toString()));
    }
  }

  void selectService(Service service) {
    final currentState = state;

    if (currentState is SuccessState) {
      emit(currentState.copyWith(selectedService: service));
    }
  }

  void selectCourier(Courier courier) {
    final currentState = state;
    final services = courier.services;
    final selectedService = services.isNotEmpty ? services.first : null;

    if (currentState is SuccessState) {
      emit(currentState.copyWith(
          selectedCourier: courier,
          services: courier.services,
          selectedService: selectedService));
    }
  }
}
