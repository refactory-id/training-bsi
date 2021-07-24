import 'dart:async';
import 'package:clean_todo_app/domain/repositories/todo_repository.dart';
import 'package:clean_todo_app/domain/requests/create_todo_request.dart';
import 'package:clean_todo_app/domain/requests/todo_request.dart';
import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:clean_todo_app/domain/usecases/create_todo_use_case.dart';

class CreateTodoUseCaseImpl extends CreateTodoUseCase {
  final TodoRepository _repository;

  CreateTodoUseCaseImpl(this._repository);

  @override
  Future<Stream<Todo>> buildUseCaseStream(TodoRequest? params) async {
    final streamController = StreamController<Todo>();

    try {
      final todo = await _repository.createTodo(params as CreateTodoRequest?);

      streamController.add(todo);
    } catch (e) {
      streamController.addError(e);
    } finally {
      streamController.close();
    }

    return streamController.stream;
  }
}
