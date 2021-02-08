import 'package:flutter/material.dart';
import 'package:flutter_provider/models/raja_ongkir_model.dart';
import 'package:flutter_provider/repositories/raja_ongkir_repository.dart';
import 'package:provider/provider.dart';

class DeliveryCostProvider extends ChangeNotifier {
  final RajaOngkirRepository _repository;

  DeliveryCostProvider(this._repository);

  static DeliveryCostProvider read(BuildContext context) {
    return Provider.of<DeliveryCostProvider>(context, listen: false);
  }

  List<DeliveryCost> _couriers;
  List<DeliveryCost> get couriers => _couriers;

  DeliveryCost _selectedCourier;
  DeliveryCost get selectedCourier => _selectedCourier;

  List<Cost> _services;
  List<Cost> get services => _services;

  Cost _selectedService;
  Cost get selectedService => _selectedService;

  int _cost;
  int get cost => _cost;

  Future<List<DeliveryCost>> fetchAllCouriers(
      String origin, String destination, int weight) {
    final jne = <String, dynamic>{
      "weight": weight,
      "origin": origin,
      "destination": destination,
      "courier": "jne"
    };

    final tiki = Map.of(jne);
    tiki["courier"] = "tiki";

    final pos = Map.of(jne);
    pos["courier"] = "pos";

    return Future.wait([
      _repository.calaculateCost(jne),
      _repository.calaculateCost(tiki),
      _repository.calaculateCost(pos)
    ]).then((value) {
      _couriers = value.map<DeliveryCost>((e) => e.first).toList();
      _selectedCourier = couriers.first;
      _services = selectedCourier.costs;
      _selectedService = services.isNotEmpty ? services.first : null;

      return couriers;
    });
  }

  void selectCourier(DeliveryCost courier) {
    _selectedCourier = courier;
    _services = courier.costs;
    _selectedService = services.isNotEmpty ? services.first : null;
    notifyListeners();
  }

  void selectService(Cost service) {
    _selectedService = service;
    notifyListeners();
  }
}
