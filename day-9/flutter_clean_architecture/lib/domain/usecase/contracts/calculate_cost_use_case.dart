import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';

abstract class CalculateCostUseCase {
  Future<List<Courier>> call(Map<String, dynamic> body);
}
