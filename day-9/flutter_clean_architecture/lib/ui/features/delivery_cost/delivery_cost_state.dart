import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/service_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';

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
  final List<Courier> couriers;
  final Courier selectedCourier;
  final List<Service> services;
  final Service selectedService;
  final int cost;

  SuccessState(
      {this.couriers,
      this.selectedCourier,
      this.cost,
      this.services,
      this.selectedService});

  SuccessState copyWith(
          {Courier selectedCourier,
          int cost,
          List<Courier> couriers,
          List<Service> services,
          Service selectedService}) =>
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
