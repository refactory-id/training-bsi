import 'package:dio/dio.dart';
import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/entities/service_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';
import 'package:flutter_clean_arch/ui/features/delivery_cost/delivery_cost_presenter.dart';
import 'package:flutter_clean_arch/usecase/cases/calculate_cost_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeliveryCostController extends Controller {
  final DeliveryCostPresenter _presenter;

  DeliveryCostController(this._presenter);

  List<Courier> couriers;
  Courier selectedCourier;
  List<Service> services;
  Service selectedService;
  int cost;

  bool isLoading = true;

  void calculateCost(String origin, String destination, int weight) {
    final CalculateCostBody jne = CalculateCostBodyImpl(
        weight: weight,
        origin: origin,
        destination: destination,
        courier: "jne");

    final CalculateCostBody tiki = jne.copyWith(courier: "tiki");
    final CalculateCostBody pos = jne.copyWith(courier: "pos");

    _presenter.calculateCost([jne, tiki, pos]);
  }

  void selectService(Service service) {
    selectedService = service;
    refreshUI();
  }

  void selectCourier(Courier courier) {
    selectedCourier = courier;
    services = courier.services;
    selectedService = services.isNotEmpty ? services.first : null;

    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.onComplete = () {
      isLoading = false;
      refreshUI();
    };

    _presenter.onError = (e) {
      String error;

      if (e is DioError)
        error = e.response.data["rajaongkir"]["status"]["description"];
      else
        error = e.toString() ?? "Oops something went wrong";

      logger.info(error);
    };

    _presenter.onSuccess = (result) {
      couriers = result;
      selectedCourier = couriers.first;
      services = selectedCourier.services;
      selectedService = services.isNotEmpty ? services.first : null;
    };
  }
}
