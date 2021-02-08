class Province {
  final String id, name;

  Province({this.id, this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json["province_id"] ?? "0",
      name: json["province"] ?? "",
    );
  }
}
