import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final String id, name;

  Province({this.id, this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json["province_id"] ?? "0",
      name: json["province"] ?? "",
    );
  }

  @override
  List<Object> get props => [id, name];
}
