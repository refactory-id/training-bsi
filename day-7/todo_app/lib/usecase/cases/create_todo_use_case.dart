import 'package:todo_app/domain/requests/create_todo_request.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/usecases/create_todo_use_case.dart';
import 'package:todo_app/usecase/repositories/todo_repository.dart';

class CreateTodoUseCaseImpl implements CreateTodoUseCase {
  final TodoRepository _repository;

  CreateTodoUseCaseImpl(this._repository);

  @override
  Future<Todo> execute(CreateTodoRequest request) {
    return _repository.createTodo(request);
  }
}
