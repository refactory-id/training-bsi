import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/province_entity.dart';
import 'package:flutter_clean_architecture/domain/usecase/get_cities_by_province_use_case.dart';
import 'package:flutter_clean_architecture/domain/usecase/get_provinces_use_case.dart';
import 'package:flutter_clean_architecture/ui/features/delivery/delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  final GetProvinceUseCase _getProvinceUseCase;
  final GetCitiesByProvinceUseCase _getCitiesByProvinceUseCase;

  DeliveryCubit(this._getProvinceUseCase, this._getCitiesByProvinceUseCase)
      : super(null);

  Future<void> fetchProvinces() async {
    emit(LoadingState());

    try {
      final provinces = await _getProvinceUseCase.call();
      final province = provinces.first;

      final cities = await _getCitiesByProvinceUseCase.call(province.id);

      final selectedProvince = province;
      final selectedDestinationProvince = selectedProvince;

      final selectedCity = cities.first;
      final selectedDestinationCity = selectedCity;

      emit(SuccessState(
          selectedDestinationProvince: selectedDestinationProvince,
          selectedProvince: selectedProvince,
          selectedCity: selectedCity,
          selectedDestinationCity: selectedDestinationCity,
          cities: cities,
          provinces: provinces,
          destinationCities: cities,
          destinationProvinces: provinces));
    } catch (e) {
      if (e is DioError) {
        final message = e.response.data["rajaongkir"]["status"]["description"];

        emit(ErrorState(message));
      } else
        emit(ErrorState(e.toString()));
    }
  }

  void _handleError(SuccessState currentState, dynamic e) async {
    if (e is DioError) {
      final message = e.response.data["rajaongkir"]["status"]["description"];

      emit(ErrorState(message));
    } else
      emit(ErrorState(e.toString()));

    await Future.delayed(Duration(seconds: 1));

    emit(currentState);
  }

  void selectProvince(Province province) async {
    final currentState = state;

    emit(LoadingState());

    try {
      if (currentState is SuccessState) {
        final cities = await _getCitiesByProvinceUseCase.call(province.id);
        final selectedCity = cities.first;

        emit(currentState.copyWith(
            selectedProvince: province,
            cities: cities,
            selectedCity: selectedCity));
      }
    } catch (e) {
      _handleError(currentState, e);
    }
  }

  void selectDestinationProvince(Province province) async {
    final currentState = state;

    emit(LoadingState());

    try {
      if (currentState is SuccessState) {
        final cities = await _getCitiesByProvinceUseCase.call(province.id);
        final selectedCity = cities.first;

        emit(currentState.copyWith(
            selectedDestinationProvince: province,
            destinationCities: cities,
            selectedDestinationCity: selectedCity));
      }
    } catch (e) {
      _handleError(currentState, e);
    }
  }

  void selectCity(City city) {
    final currentState = state;

    if (currentState is SuccessState)
      emit(currentState.copyWith(selectedCity: city));
  }

  void selectDestinationCity(City city) {
    final currentState = state;

    if (currentState is SuccessState)
      emit(currentState.copyWith(selectedDestinationCity: city));
  }
}
