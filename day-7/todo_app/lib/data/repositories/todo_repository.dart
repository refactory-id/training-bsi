import 'package:todo_app/data/services/todo_service.dart';
import 'package:todo_app/domain/requests/create_todo_request.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/usecase/mappers/todo_mapper.dart';
import 'package:todo_app/usecase/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoService _service;
  final TodoMapper _mapper;

  TodoRepositoryImpl(this._service, this._mapper);

  @override
  Future<Todo> createTodo(CreateTodoRequest request) {
    final body = _mapper.requestToJson(request);

    return _service.createTodo(body).then((response) {
      final todo = _mapper.responseToEntity(response.data["data"]);
      return todo;
    }).catchError((e) => print(e));
  }

  @override
  Future<List<Todo>> getTodos() {
    return _service.getTodos().then((response) {
      final todos = _mapper.responsesToEntityList(response.data);
      return todos;
    }).catchError((e) => print(e));
  }
}
