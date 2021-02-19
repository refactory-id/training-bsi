import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final bool status;
  final String task, date;

  Todo({this.id, this.status, this.task, this.date});

  Todo copy({int id, bool status, String task, String date}) {
    return Todo(
      id: id ?? this.id,
      status: status ?? this.status,
      task: task ?? this.task,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [id, status, task, date];
}
