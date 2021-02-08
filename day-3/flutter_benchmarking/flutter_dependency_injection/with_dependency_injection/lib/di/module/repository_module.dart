import 'package:with_dependency_injection/repositories/todo_repository.dart';
import 'package:with_dependency_injection/services/todo_service.dart';
import 'package:injector/injector.dart';

class RepositoryModule {
  static void init(Injector injector) {
    injector.registerSingleton<TodoRepository>(
        () => TodoRepositoryImpl(injector.get<TodoService>()));
  }
}
