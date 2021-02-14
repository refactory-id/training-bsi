import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';
import 'package:flutter_clean_architecture/usecase/mappers/province_mapper.dart';

class ProvinceMapperImpl implements ProvinceMapper {
  @override
  List<Province> toDomainList(response) {
    final provinces = <Province>[];
    final results = response["rajaongkir"]["results"];

    results?.forEach((province) {
      provinces.add(Province(
        id: province["province_id"] ?? "0",
        name: province["province"] ?? "",
      ));
    });

    return provinces;
  }
}
