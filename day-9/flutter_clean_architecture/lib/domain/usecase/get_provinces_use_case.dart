import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';

abstract class GetProvinceUseCase {
  Future<List<Province>> call();
}
