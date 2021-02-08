import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery/delivery_state.dart';
import 'package:flutter_bloc_state_management/blocs/delivery/delivery_event.dart';
import 'package:flutter_bloc_state_management/repositories/raja_ongkir_repository.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  final RajaOngkirRepository _repository;

  DeliveryBloc(this._repository) : super(null);

  @override
  Stream<DeliveryState> mapEventToState(DeliveryEvent event) async* {
    final currentState = state;

    if (event is FetchAllProvincesEvent) {
      yield LoadingState();

      try {
        final provinces = await _repository.getAllProvinces();
        final province = provinces.first;

        final cities = await _repository.getAllCitiesByProvince(province.id);

        final selectedProvince = province;
        final selectedDestinationProvince = selectedProvince;

        final selectedCity = cities.first;
        final selectedDestinationCity = selectedCity;

        yield SuccessState(
            selectedDestinationProvince: selectedDestinationProvince,
            selectedProvince: selectedProvince,
            selectedCity: selectedCity,
            selectedDestinationCity: selectedDestinationCity,
            cities: cities,
            provinces: provinces,
            destinationCities: cities,
            destinationProvinces: provinces);
      } catch (e) {
        if (e is DioError) {
          final message =
              e.response.data["rajaongkir"]["status"]["description"];

          yield ErrorState(message);
        } else
          yield ErrorState(e.toString());

        await Future.delayed(Duration(seconds: 1));

        yield currentState;
      }
    } else if (event is SelectProvinceEvent && currentState is SuccessState) {
      try {
        final cities =
            await _repository.getAllCitiesByProvince(event.province.id);
        final selectedCity = cities.first;

        yield currentState.copyWith(
            selectedProvince: event.province,
            cities: cities,
            selectedCity: selectedCity);
      } catch (e) {
        if (e is DioError) {
          final message =
              e.response.data["rajaongkir"]["status"]["description"];

          yield ErrorState(message);
        } else
          yield ErrorState(e.toString());

        await Future.delayed(Duration(seconds: 1));

        yield currentState;
      }
    } else if (event is SelectDestionationProvinceEvent &&
        currentState is SuccessState) {
      try {
        final cities =
            await _repository.getAllCitiesByProvince(event.province.id);
        final selectedCity = cities.first;

        yield currentState.copyWith(
            selectedDestinationProvince: event.province,
            destinationCities: cities,
            selectedDestinationCity: selectedCity);
      } catch (e) {
        if (e is DioError) {
          final message =
              e.response.data["rajaongkir"]["status"]["description"];

          yield ErrorState(message);
        } else
          yield ErrorState(e.toString());

        await Future.delayed(Duration(seconds: 1));

        yield currentState;
      }
    } else if (event is SelectCityEvent && currentState is SuccessState) {
      yield currentState.copyWith(selectedCity: event.city);
    } else if (event is SelectDestionationCityEvent &&
        currentState is SuccessState) {
      yield currentState.copyWith(selectedDestinationCity: event.city);
    }
  }
}
