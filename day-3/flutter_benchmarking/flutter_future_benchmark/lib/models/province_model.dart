class ProvinceResponse {
  Rajaongkir? rajaongkir;

  ProvinceResponse({this.rajaongkir});

  ProvinceResponse.fromJson(Map<String, dynamic> json) {
    rajaongkir = json['rajaongkir'] != null
        ? Rajaongkir.fromJson(json['rajaongkir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.rajaongkir != null) {
      data['rajaongkir'] = this.rajaongkir!.toJson();
    }
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
    data['results'] = this.results?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Query {
  String? id;

  Query({this.id});

  Query.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Status {
  int? code;
  String? description;

  Status({this.code, this.description});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class Results {
  String? provinceId;
  String? province;

  Results({this.provinceId, this.province});

  Results.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['province'] = this.province;
    return data;
  }
}
