import 'package:dio/dio.dart';
import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/entities/province_entity.dart';
import 'package:flutter_clean_arch/ui/features/delivery/delivery_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeliveryController extends Controller {
  final DeliveryPresenter _presenter;

  DeliveryController(this._presenter);

  Province selectedProvince, selectedDestinationProvince;

  City selectedCity, selectedDestinationCity;

  List<Province> provinces, destinationProvinces;

  List<City> cities, destinationCities;

  bool isLoading = true;

  void getProvinces() {
    isLoading = true;
    refreshUI();

    _presenter.getProvinces();
  }

  void _showLoading() {
    isLoading = true;
    refreshUI();
  }

  void _hideLoading() {
    isLoading = false;
    refreshUI();
  }

  void selectProvince(Province province) {
    selectedProvince = province;

    _showLoading();

    _presenter.getOriginCities(province.id);
  }

  void selectDestinationProvince(Province province) {
    selectedDestinationProvince = province;

    _showLoading();

    _presenter.getDestinationCities(province.id);
  }

  void selectCity(City city) {
    selectedCity = city;
    refreshUI();
  }

  void selectDestinationCity(City city) {
    selectedDestinationCity = city;
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.onError = (e) {
      String error;

      if (e is DioError)
        error = e.response.data["rajaongkir"]["status"]["description"];
      else
        error = e?.toString() ?? "Oops something went wrong";

      logger.info(error);
    };

    _presenter.onComplete = () => _hideLoading();

    _presenter.onSuccessGetProvince = (result) {
      provinces = result;
      destinationProvinces = result;

      selectedProvince = result.first;
      selectedDestinationProvince = result.first;

      _presenter.getCitiesByProvince(selectedProvince.id);
    };

    _presenter.onSuccessGetCities = (result) {
      cities = result;
      destinationCities = result;

      selectedCity = result.first;
      selectedDestinationCity = result.first;
    };

    _presenter.onSuccessGetOriginCities = (result) {
      cities = result;
      selectedCity = result.first;
    };

    _presenter.onSuccessGetDestinationCities = (result) {
      destinationCities = result;
      selectedDestinationCity = result.first;
    };
  }
}
