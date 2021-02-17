import 'package:todo_app/domain/requests/create_todo_request.dart';
import 'package:todo_app/domain/requests/todo_request.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/usecase/mappers/todo_mapper.dart';

class TodoMapperImpl implements TodoMapper {
  @override
  Map<String, dynamic> requestToJson(TodoRequest request) {
    if (request is CreateTodoRequest) {
      return <String, dynamic>{
        "task": request.task,
        "status": request.status,
      };
    } else {
      return <String, dynamic>{};
    }
  }

  @override
  Todo responseToEntity(response) {
    return Todo(
      id: response["id"] ?? 0,
      status: response["status"] ?? false,
      task: response["task"] ?? "",
      date: response["date"] ?? "",
    );
  }

  @override
  List<Todo> responsesToEntityList(response) {
    final todos = <Todo>[];

    response["data"]?.forEach((json) {
      todos.add(responseToEntity(json));
    });

    return todos;
  }
}
