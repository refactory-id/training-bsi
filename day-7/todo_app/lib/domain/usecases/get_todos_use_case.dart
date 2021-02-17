import 'package:todo_app/domain/entities/todo_entity.dart';

abstract class GetTodosUseCase {
  Future<List<Todo>> execute();
}