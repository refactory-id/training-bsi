import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/requests/create_todo_request.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<Todo> createTodo(CreateTodoRequest request);
}
