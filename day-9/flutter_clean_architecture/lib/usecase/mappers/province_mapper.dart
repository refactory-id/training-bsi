import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';

abstract class ProvinceMapper {
  List<Province> toDomainList(dynamic response);
}
