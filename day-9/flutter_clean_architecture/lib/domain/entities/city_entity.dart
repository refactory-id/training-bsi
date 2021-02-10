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

  @override
  List<Object> get props => [id, name, provinceId, province, type, postalCode];
}
