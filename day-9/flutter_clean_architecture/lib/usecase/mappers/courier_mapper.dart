import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';

abstract class CourierMapper {
  List<Courier> toDomainList(dynamic response);
}
