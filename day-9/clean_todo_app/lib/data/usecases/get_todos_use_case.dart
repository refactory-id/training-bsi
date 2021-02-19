import 'dart:async';

import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:clean_todo_app/domain/repositories/todo_repository.dart';
import 'package:clean_todo_app/domain/usecases/get_todos_use_case.dart';

class GetTodosUseCaseImpl extends GetTodosUseCase {
  final TodoRepository _repository;

  GetTodosUseCaseImpl(this._repository);

  @override
  Future<Stream<List<Todo>>> buildUseCaseStream(void params) async {
    final streamController = StreamController<List<Todo>>();

    try {
      final todos = await _repository.getTodos();

      streamController.add(todos);
    } catch (e) {
      streamController.addError(e);
    } finally {
      streamController.close();
    }

    return streamController.stream;
  }
}
