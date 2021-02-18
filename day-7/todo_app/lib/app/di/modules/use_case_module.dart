import 'package:injector/injector.dart';
import 'package:todo_app/domain/usecases/create_todo_use_case.dart';
import 'package:todo_app/domain/usecases/get_todos_use_case.dart';
import 'package:todo_app/usecase/cases/create_todo_use_case.dart';
import 'package:todo_app/usecase/cases/get_todos_use_case.dart';

class UseCaseModule {
  static inject(Injector injector) {
    injector.registerDependency<GetTodosUseCase>(
        () => GetTodosUseCaseImpl(injector.get()));
    injector.registerDependency<CreateTodoUseCase>(
        () => CreateTodoUseCaseImpl(injector.get()));
  }
}
