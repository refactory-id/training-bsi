import 'package:flutter_clean_arch/domain/entities/cost_entity.dart';

class Service {
  final String service, description;
  final List<Cost> costs;

  Service({this.service, this.description, this.costs});
}
