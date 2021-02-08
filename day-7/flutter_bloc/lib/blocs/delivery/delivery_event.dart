import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_state_management/models/city_model.dart';
import 'package:flutter_bloc_state_management/models/province_model.dart';

abstract class DeliveryEvent extends Equatable {}

class FetchAllProvincesEvent extends DeliveryEvent {
  @override
  List<Object> get props => [];
}

class SelectProvinceEvent extends DeliveryEvent {
  final Province province;

  SelectProvinceEvent(this.province);

  @override
  List<Object> get props => [province];
}

class SelectCityEvent extends DeliveryEvent {
  final City city;

  SelectCityEvent(this.city);

  @override
  List<Object> get props => [city];
}

class SelectDestionationProvinceEvent extends DeliveryEvent {
  final Province province;

  SelectDestionationProvinceEvent(this.province);

  @override
  List<Object> get props => [province];
}

class SelectDestionationCityEvent extends DeliveryEvent {
  final City city;

  SelectDestionationCityEvent(this.city);

  @override
  List<Object> get props => [city];
}
