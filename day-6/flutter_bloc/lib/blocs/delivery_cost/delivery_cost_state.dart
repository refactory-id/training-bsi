import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_state_management/models/raja_ongkir_model.dart';

abstract class DeliveryCostState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends DeliveryCostState {}

class ErrorState extends DeliveryCostState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessState extends DeliveryCostState {
  final List<DeliveryCost> couriers;
  final DeliveryCost selectedCourier;
  final List<Cost> services;
  final Cost selectedService;
  final int cost;

  SuccessState(
      {this.couriers,
      this.selectedCourier,
      this.cost,
      this.services,
      this.selectedService});

  SuccessState copyWith(
          {DeliveryCost selectedCourier,
          int cost,
          List<DeliveryCost> couriers,
          List<Cost> services,
          Cost selectedService}) =>
      SuccessState(
          selectedCourier: selectedCourier ?? this.selectedCourier,
          cost: cost ?? this.cost,
          services: services ?? this.services,
          selectedService: selectedService,
          couriers: couriers ?? this.couriers);

  @override
  List<Object> get props =>
      [selectedCourier, couriers, services, selectedService];
}
