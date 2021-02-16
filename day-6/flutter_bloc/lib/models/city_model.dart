import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String id, name, provinceId, province, type, postalCode;

  City(
      {this.id,
      this.name,
      this.provinceId,
      this.province,
      this.type,
      this.postalCode});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json["city_id"] ?? "0",
        name: json["city_name"] ?? "",
        provinceId: json["province_id"] ?? "0",
        province: json["province"] ?? "",
        type: json["type"] ?? "",
        postalCode: json["postal_code"] ?? "");
  }

  @override
  List<Object> get props => [id, name, provinceId, province, type, postalCode];
}
