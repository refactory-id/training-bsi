import 'package:injector/injector.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/usecase/repositories/todo_repository.dart';

class RepositoryModule {
  static inject(Injector injector) {
    injector.registerDependency<TodoRepository>(
        () => TodoRepositoryImpl(injector.get(), injector.get()));
  }
}
