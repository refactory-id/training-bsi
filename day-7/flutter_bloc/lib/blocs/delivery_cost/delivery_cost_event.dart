import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_state_management/models/raja_ongkir_model.dart';

abstract class DeliveryCostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectCourierEvent extends DeliveryCostEvent {
  final DeliveryCost courier;

  SelectCourierEvent(this.courier);

  @override
  List<Object> get props => [courier];
}

class SelectServiceEvent extends DeliveryCostEvent {
  final Cost service;

  SelectServiceEvent(this.service);

  @override
  List<Object> get props => [service];
}

class CalculateCostEvent extends DeliveryCostEvent {
  final int weight;
  final String origin, destination;

  CalculateCostEvent(this.origin, this.destination, this.weight);

  @override
  List<Object> get props => [origin, destination, weight];
}
