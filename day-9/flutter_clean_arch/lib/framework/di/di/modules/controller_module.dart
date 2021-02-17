import 'package:flutter_clean_arch/ui/features/delivery/delivery_controller.dart';
import 'package:flutter_clean_arch/ui/features/delivery_cost/delivery_cost_controller.dart';
import 'package:injector/injector.dart';

class ControllerModule {
  static inject(Injector injector) {
    injector.registerDependency(() => DeliveryController(injector.get()));
    injector.registerDependency(() => DeliveryCostController(injector.get()));
  }
}
