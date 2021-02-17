import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';

abstract class CourierMapper {
  List<Courier> toDomainList(dynamic response);
  Map<String, dynamic> toRequestBody(CalculateCostBody body);
}
