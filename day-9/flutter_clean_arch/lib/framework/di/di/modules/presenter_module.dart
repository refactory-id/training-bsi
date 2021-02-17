import 'package:flutter_clean_arch/ui/features/delivery/delivery_presenter.dart';
import 'package:flutter_clean_arch/ui/features/delivery_cost/delivery_cost_presenter.dart';
import 'package:injector/injector.dart';

class PresenterModule {
  static inject(Injector injector) {
    injector.registerDependency(
        () => DeliveryPresenter(injector.get(), injector.get()));
    injector.registerDependency(() => DeliveryCostPresenter(injector.get()));
  }
}
