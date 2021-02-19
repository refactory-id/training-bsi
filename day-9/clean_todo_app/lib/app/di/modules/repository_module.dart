import 'package:clean_todo_app/data/repositories/todo_repository.dart';
import 'package:clean_todo_app/domain/repositories/todo_repository.dart';
import 'package:injector/injector.dart';

class RepositoryModule {
  static inject(Injector injector) {
    injector.registerDependency<TodoRepository>(
        () => TodoRepositoryImpl(injector.get(), injector.get()));
  }
}
