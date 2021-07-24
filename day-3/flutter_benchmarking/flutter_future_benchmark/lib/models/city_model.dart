class CityResponse {
  Rajaongkir? rajaongkir;

  CityResponse({this.rajaongkir});

  CityResponse.fromJson(Map<String, dynamic> json) {
    rajaongkir = json['rajaongkir'] != null
        ? Rajaongkir.fromJson(json['rajaongkir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rajaongkir'] = rajaongkir?.toJson();
    return data;
  }
}

class Rajaongkir {
  List<Results>? results;

  Rajaongkir({this.results});

  Rajaongkir.fromJson(Map<String, dynamic> json) {
    results = <Results>[];

    json['results'].forEach((v) {
      results?.add(Results.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['results'] = results?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Query {
  late String province;
  late String id;

  Query({required this.province, required this.id});

  Query.fromJson(Map<String, dynamic> json) {
    province = json['province'] ?? '';
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['province'] = this.province;
    data['id'] = this.id;
    return data;
  }
}

class Status {
  late int code;
  late String description;

  Status({required this.code, required this.description});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? 0;
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class Results {
  late String cityId, provinceId, province, type, cityName, postalCode;

  Results(
      {required this.cityId,
      required this.provinceId,
      required this.province,
      required this.type,
      required this.cityName,
      required this.postalCode});

  Results.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'] ?? '';
    provinceId = json['province_id'] ?? '';
    province = json['province'] ?? '';
    type = json['type'] ?? '';
    cityName = json['city_name'] ?? '';
    postalCode = json['postal_code'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['province_id'] = this.provinceId;
    data['province'] = this.province;
    data['type'] = this.type;
    data['city_name'] = this.cityName;
    data['postal_code'] = this.postalCode;
    return data;
  }
}
