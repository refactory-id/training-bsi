import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/service_entity.dart';

class Courier extends Equatable {
  final String name, code;
  final List<Service> services;

  Courier({this.name, this.code, this.services});

  @override
  List<Object> get props => [name, code, services];
}
