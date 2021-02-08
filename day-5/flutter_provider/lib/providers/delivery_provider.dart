import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/models/city_model.dart';
import 'package:flutter_provider/models/province_model.dart';
import 'package:flutter_provider/models/raja_ongkir_model.dart';
import 'package:flutter_provider/repositories/raja_ongkir_repository.dart';
import 'package:provider/provider.dart';

abstract class State {}

class Success extends State {}

class Loading extends State {}

class Error extends State {
  final String message;

  Error(this.message);
}

class DeliveryProvider extends ChangeNotifier {
  final RajaOngkirRepository _repository;

  DeliveryProvider(this._repository);

  static DeliveryProvider read(BuildContext context) {
    return Provider.of<DeliveryProvider>(context, listen: false);
  }

  State _state;
  State get state => _state;
  set state(State value) {
    _state = value;
    notifyListeners();
  }

  List<Province> _provinces = [], _destinationProvinces = [];
  List<Province> get provinces => _provinces;
  List<Province> get destinationProvinces => _destinationProvinces;

  List<City> _cities = [], _destinationCities = [];
  List<City> get cities => _cities;
  List<City> get destinationCities => _destinationCities;

  List<Cost> _deliveryCost = [];
  List<Cost> get deliveryCost => _deliveryCost;

  Province _selectedProvince, _selectedDestinationProvince;
  Province get selectedProvince => _selectedProvince;
  Province get selectedDestinationProvince => _selectedDestinationProvince;

  City _selectedCity, _selectedDestinationCity;
  City get selectedCity => _selectedCity;
  City get selectedDestinationCity => _selectedDestinationCity;

  void _success() {
    state = Success();
  }

  void _error(dynamic e) {
    print(e);

    if (e is DioError) {
      final response = e.response.data;

      state = Error(response["rajaongkir"]["status"]["description"]);
    } else {
      state = Error(e?.message ?? "Oops something went wrong!");
    }

    Future.delayed(Duration(seconds: 1), () {
      state = Success();
    });
  }

  Future<List<dynamic>> getAllRegion() {
    return _repository.getAllProvinces().then((value) async {
      _provinces = value;
      _destinationProvinces = _provinces;

      _selectedProvince = _provinces.first;
      _selectedDestinationProvince = _selectedProvince;

      _cities = await _repository.getAllCitiesByProvince(_selectedProvince.id);
      _destinationCities = _cities;

      _selectedCity = _cities.first;
      _selectedDestinationCity = _selectedCity;

      return value;
    });
  }

  void selectProvince(Province province) async {
    state = Loading();

    try {
      _selectedProvince = province;
      _cities = await _repository.getAllCitiesByProvince(province.id);
      _selectedCity = _cities.first;

      _success();
    } catch (e) {
      _error(e);
    }
  }

  void selectCity(City city) {
    _selectedCity = city;
    notifyListeners();
  }

  void selectDestionationProvince(Province province) async {
    state = Loading();

    try {
      _selectedDestinationProvince = province;
      _destinationCities =
          await _repository.getAllCitiesByProvince(province.id);
      _selectedDestinationCity = _destinationCities.first;

      _success();
    } catch (e) {
      _error(e);
    }
  }

  void selectDestionationCity(City city) {
    _selectedDestinationCity = city;
    notifyListeners();
  }
}
