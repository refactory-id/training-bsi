import 'package:flutter_clean_arch/domain/entities/service_entity.dart';

class Courier {
  final String name, code;
  final List<Service> services;

  Courier({this.name, this.code, this.services});
}
