import 'package:flutter_future_benchmark/models/city_model.dart' as City;
import 'package:flutter_future_benchmark/models/province_model.dart'
    as Province;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';

void main() async {
  final url = "https://api.rajaongkir.com/starter";
  final cityUrl = "$url/city";
  final provinceUrl = "$url/province";
  final headers = <String, String>{"key": "d4bb9252bfe68b20fecb0846e4d7754f"};

  Future<List<Province.Results>> getAllProvince() =>
      Http.get(Uri.parse(provinceUrl), headers: headers).then((value) {
        final json = jsonDecode(value.body);
        return Province.ProvinceResponse.fromJson(json).rajaongkir?.results ??
            [];
      });

  Future<List<City.Results>> getAllCity() =>
      Http.get(Uri.parse(cityUrl), headers: headers).then((value) {
        final json = jsonDecode(value.body);
        return City.CityResponse.fromJson(json).rajaongkir?.results ?? [];
      });

  group("Future benchmarking", () {
    test("Future without concurrency", () async {
      final start = DateTime.now().millisecondsSinceEpoch;
      final provinces = await getAllProvince();

      expect(provinces, isNotNull);

      final firstProvince = provinces.first;
      final cities = await getAllCity();

      expect(firstProvince, isNotNull);
      expect(cities, isNotNull);

      final filteredCitiesById =
          cities.where((city) => city.provinceId == firstProvince.provinceId);

      expect(filteredCitiesById.length, isNonZero);

      print(filteredCitiesById.map((e) => e.toJson()));

      final end = DateTime.now().millisecondsSinceEpoch;

      print("Done at ${(end - start) / 1000} seconds");
    });

    test("Future with concurrency", () async {
      final start = DateTime.now().millisecondsSinceEpoch;
      final results = await Future.wait([getAllProvince(), getAllCity()]);

      final provinces = results.first as List<Province.Results>;
      final cities = results.last as List<City.Results>;

      expect(provinces, isNotNull);
      expect(cities, isNotNull);

      final firstProvince = provinces.first;

      expect(firstProvince, isNotNull);

      final filteredCitiesById =
          cities.where((city) => city.provinceId == firstProvince.provinceId);

      expect(filteredCitiesById.length, isNonZero);

      print(filteredCitiesById.map((e) => e.toJson()));

      final end = DateTime.now().millisecondsSinceEpoch;

      print("Done at ${(end - start) / 1000} seconds");
    });
  });
}
