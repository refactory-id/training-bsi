import 'package:clean_todo_app/data/usecases/create_todo_use_case.dart';
import 'package:clean_todo_app/data/usecases/get_todos_use_case.dart';
import 'package:clean_todo_app/domain/usecases/create_todo_use_case.dart';
import 'package:clean_todo_app/domain/usecases/get_todos_use_case.dart';
import 'package:injector/injector.dart';

class UseCaseModule {
  static inject(Injector injector) {
    injector.registerDependency<GetTodosUseCase>(
        () => GetTodosUseCaseImpl(injector.get()));
    injector.registerDependency<CreateTodoUseCase>(
        () => CreateTodoUseCaseImpl(injector.get()));
  }
}
