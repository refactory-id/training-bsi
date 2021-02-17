import 'package:todo_app/domain/entities/todo_entity.dart';
import 'package:todo_app/domain/usecases/get_todos_use_case.dart';
import 'package:todo_app/usecase/repositories/todo_repository.dart';

class GetTodosUseCaseImpl implements GetTodosUseCase {
  final TodoRepository _repository;

  GetTodosUseCaseImpl(this._repository);

  @override
  Future<List<Todo>> execute() {
    return _repository.getTodos();
  }
}
