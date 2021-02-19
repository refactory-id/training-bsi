import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:clean_todo_app/domain/requests/todo_request.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

abstract class CreateTodoUseCase extends UseCase<Todo, TodoRequest> {}
