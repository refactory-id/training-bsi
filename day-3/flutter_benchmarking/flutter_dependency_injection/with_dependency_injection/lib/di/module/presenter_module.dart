import 'package:with_dependency_injection/presenters/todo_presenter.dart';
import 'package:with_dependency_injection/repositories/todo_repository.dart';
import 'package:injector/injector.dart';

class PresenterModule {
  static void init(Injector injector) {
    injector.registerDependency<TodoPresenterImpl>(
        () => TodoPresenterImpl(injector.get<TodoRepository>()));

    injector.registerDependency<TodoPresenter>(
        () => injector.get<TodoPresenterImpl>());
  }
}
