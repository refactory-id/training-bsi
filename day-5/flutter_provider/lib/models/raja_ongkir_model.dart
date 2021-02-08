class DeliveryCost {
  final String name, code;
  final List<Cost> costs;

  DeliveryCost({this.name, this.code, this.costs});

  factory DeliveryCost.fromJson(Map<String, dynamic> json) {
    final costs = <Cost>[];

    json["costs"]?.forEach((json) {
      costs.add(Cost.fromJson(json));
    });

    return DeliveryCost(
      name: json["name"] ?? "",
      code: json["code"] ?? "",
      costs: costs,
    );
  }
}

class Cost {
  final String service, description;
  final List<CostItem> cost;

  Cost({this.service, this.description, this.cost});

  factory Cost.fromJson(Map<String, dynamic> json) {
    final costItems = <CostItem>[];

    json["cost"]?.forEach((json) {
      costItems.add(CostItem.fromJson(json));
    });

    return Cost(
      service: json["service"] ?? "",
      description: json["description"] ?? "",
      cost: costItems,
    );
  }
}

class CostItem {
  final String etd, note;
  final int value;

  CostItem({this.etd, this.note, this.value});

  factory CostItem.fromJson(Map<String, dynamic> json) {
    return CostItem(
      etd: json["etd"] ?? "",
      note: json["note"] ?? "",
      value: json["value"] ?? 0,
    );
  }
}
