import 'package:flutter_clean_arch/domain/entities/cost_entity.dart';
import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/entities/service_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';
import 'package:flutter_clean_arch/usecase/mappers/courier_mapper.dart';

class CourierMapperImpl implements CourierMapper {
  @override
  List<Courier> toDomainList(response) {
    final couriers = <Courier>[];
    final results = response["rajaongkir"]["results"];

    results?.forEach((courier) {
      final services = <Service>[];

      courier["costs"]?.forEach((service) {
        final costs = <Cost>[];

        service["cost"]?.forEach((cost) {
          costs.add(Cost(
            etd: cost["etd"] ?? "",
            note: cost["note"] ?? "",
            value: cost["value"] ?? 0,
          ));
        });

        services.add(Service(
            service: service["service"] ?? "",
            description: service["description"] ?? "",
            costs: costs));
      });

      couriers.add(Courier(
          name: courier["name"] ?? "",
          code: courier["code"] ?? "",
          services: services));
    });

    return couriers;
  }

  @override
  Map<String, dynamic> toRequestBody(CalculateCostBody body) {
    return <String, dynamic>{
      "weight": body.weight,
      "origin": body.origin,
      "destination": body.destination,
      "courier": body.courier,
    };
  }
}
