import 'package:flutter_clean_architecture/domain/entities/service_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/cost_entity.dart';
import 'package:flutter_clean_architecture/usecase/mappers/courier_mapper.dart';

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
}
