import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

abstract class GetTodosUseCase extends UseCase<List<Todo>, void> {}
