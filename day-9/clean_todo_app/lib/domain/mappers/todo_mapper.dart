

import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:clean_todo_app/domain/requests/todo_request.dart';

abstract class TodoMapper {
  Todo responseToEntity(dynamic response);
  List<Todo> responsesToEntityList(dynamic response);
  Map<String, dynamic> requestToJson(TodoRequest? request);
}
