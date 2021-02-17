import 'package:flutter_clean_arch/domain/entities/city_entity.dart';
import 'package:flutter_clean_arch/domain/entities/province_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/get_cities_by_province_use_case.dart';
import 'package:flutter_clean_arch/domain/usecases/get_provinces_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeliveryPresenter extends Presenter {
  final GetProvinceUseCase _getProvinceUseCase;
  final GetCitiesByProvinceUseCase _getCitiesByProvinceUseCase;

  DeliveryPresenter(this._getProvinceUseCase, this._getCitiesByProvinceUseCase);

  Function(List<Province>) onSuccessGetProvince;
  Function(List<City>) onSuccessGetCities;
  Function(List<City>) onSuccessGetOriginCities;
  Function(List<City>) onSuccessGetDestinationCities;
  Function(dynamic e) onError;
  Function onComplete;

  void getProvinces() {
    _getProvinceUseCase.execute(_ProvinceObserver(this));
  }

  void getCitiesByProvince(String id) {
    _getCitiesByProvinceUseCase.execute(_CityObserver(this), id);
  }

  void getOriginCities(String id) {
    _getCitiesByProvinceUseCase.execute(_OriginCityObserver(this), id);
  }

  void getDestinationCities(String id) {
    _getCitiesByProvinceUseCase.execute(_DestinationObserver(this), id);
  }

  @override
  void dispose() {
    _getCitiesByProvinceUseCase.dispose();
    _getProvinceUseCase.dispose();
  }
}

class _ProvinceObserver implements Observer<List<Province>> {
  final DeliveryPresenter _presenter;

  _ProvinceObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.onError(e);
  }

  @override
  void onNext(List<Province> response) {
    _presenter.onSuccessGetProvince(response);
  }
}

class _CityObserver implements Observer<List<City>> {
  final DeliveryPresenter _presenter;

  _CityObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.onComplete();
  }

  @override
  void onError(e) {
    _presenter.onError(e);
  }

  @override
  void onNext(List<City> response) {
    _presenter.onSuccessGetCities(response);
  }
}

class _OriginCityObserver extends _CityObserver {
  final DeliveryPresenter _presenter;

  _OriginCityObserver(this._presenter) : super(_presenter);

  @override
  void onNext(List<City> response) {
    _presenter.onSuccessGetOriginCities(response);
  }
}

class _DestinationObserver extends _CityObserver {
  final DeliveryPresenter _presenter;

  _DestinationObserver(this._presenter) : super(_presenter);

  @override
  void onNext(List<City> response) {
    _presenter.onSuccessGetDestinationCities(response);
  }
}
