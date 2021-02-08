import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery_cost/delivery_cost_event.dart';
import 'package:flutter_bloc_state_management/blocs/delivery_cost/delivery_cost_state.dart';
import 'package:flutter_bloc_state_management/models/raja_ongkir_model.dart';
import 'package:flutter_bloc_state_management/repositories/raja_ongkir_repository.dart';

class DeliveryCostBloc extends Bloc<DeliveryCostEvent, DeliveryCostState> {
  final RajaOngkirRepository _repository;

  DeliveryCostBloc(this._repository) : super(null);

  @override
  Stream<DeliveryCostState> mapEventToState(DeliveryCostEvent event) async* {
    final currentState = state;

    if (event is SelectCourierEvent && currentState is SuccessState) {
      final courier = event.courier;
      final services = courier.costs;
      final selectedService = services.isNotEmpty ? services.first : null;

      yield currentState.copyWith(
          selectedCourier: courier,
          services: courier.costs,
          selectedService: selectedService);
    }

    if (event is SelectServiceEvent && currentState is SuccessState) {
      yield currentState.copyWith(selectedService: event.service);
    }

    if (event is CalculateCostEvent) {
      yield LoadingState();

      try {
        final jne = <String, dynamic>{
          "weight": event.weight,
          "origin": event.origin,
          "destination": event.destination,
          "courier": "jne"
        };

        final tiki = Map.of(jne);
        tiki["courier"] = "tiki";

        final pos = Map.of(jne);
        pos["courier"] = "pos";

        final couriers = await Future.wait([
          _repository.calaculateCost(jne),
          _repository.calaculateCost(tiki),
          _repository.calaculateCost(pos)
        ]).then((value) => value.map<DeliveryCost>((e) => e.first).toList());

        final selectedCourier = couriers.first;
        final services = selectedCourier.costs;
        final selectedServices = services.isNotEmpty ? services.first : null;

        yield SuccessState(
            couriers: couriers,
            selectedCourier: selectedCourier,
            services: services,
            selectedService: selectedServices);
      } catch (e) {
        if (e is DioError) {
          final message =
              e.response.data["rajaongkir"]["status"]["description"];

          yield ErrorState(message);
        } else
          yield ErrorState(e.toString() ?? "Oops semothing went wrong");

        await Future.delayed(Duration(seconds: 1));

        yield currentState;
      }
    }
  }
}
