class TodoModel {
  int id;
  bool status;
  String task, date;

  TodoModel(
      {required this.id,
      required this.status,
      required this.task,
      required this.date});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"] ?? 0,
        status: json["status"] ?? false,
        task: json["task"] ?? "",
        date: json["date"] ?? "",
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "status": status,
        "task": task,
        "date": date,
      };
}
