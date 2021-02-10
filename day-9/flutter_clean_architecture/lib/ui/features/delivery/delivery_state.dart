import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';

abstract class DeliveryState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingState extends DeliveryState {}

class ErrorState extends DeliveryState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SuccessState extends DeliveryState {
  final Province selectedProvince, selectedDestinationProvince;

  final City selectedCity, selectedDestinationCity;

  final List<Province> provinces, destinationProvinces;

  final List<City> cities, destinationCities;

  SuccessState(
      {this.selectedProvince,
      this.selectedCity,
      this.selectedDestinationCity,
      this.selectedDestinationProvince,
      this.provinces,
      this.cities,
      this.destinationProvinces,
      this.destinationCities});

  SuccessState copyWith(
      {Province selectedProvince,
      City selectedCity,
      City selectedDestinationCity,
      Province selectedDestinationProvince,
      List<Province> provinces,
      List<City> cities,
      List<Province> destinationProvinces,
      List<City> destinationCities}) {
    return SuccessState(
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedDestinationCity:
          selectedDestinationCity ?? this.selectedDestinationCity,
      selectedDestinationProvince:
          selectedDestinationProvince ?? this.selectedDestinationProvince,
      provinces: provinces ?? this.provinces,
      cities: cities ?? this.cities,
      destinationProvinces: destinationProvinces ?? this.destinationProvinces,
      destinationCities: destinationCities ?? this.destinationCities,
    );
  }

  @override
  List<Object> get props => [
        selectedProvince,
        selectedCity,
        selectedDestinationCity,
        selectedDestinationProvince,
        provinces,
        cities,
        destinationProvinces,
        destinationCities,
      ];
}
