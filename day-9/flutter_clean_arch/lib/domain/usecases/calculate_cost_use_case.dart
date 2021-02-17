import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

abstract class CalculateCostUseCase
    extends UseCase<List<Courier>, List<CalculateCostBody>> {}

abstract class CalculateCostBody {
  int weight;
  String origin, destination, courier;
  CalculateCostBody copyWith(
      {int weight, String origin, String destination, String courier});
}
