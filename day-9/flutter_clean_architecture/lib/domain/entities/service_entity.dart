import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/cost_entity.dart';

class Service extends Equatable {
  final String service, description;
  final List<Cost> costs;

  Service({this.service, this.description, this.costs});

  @override
  List<Object> get props => [service, description, costs];
}
