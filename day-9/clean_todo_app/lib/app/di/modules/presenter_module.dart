import 'package:clean_todo_app/app/ui/features/create_todo/create_todo_presenter.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_presenter.dart';
import 'package:injector/injector.dart';

class PresenterModule {
  static inject(Injector injector) {
    injector.registerDependency(() => TodoPresenter(injector.get()));
    injector.registerDependency(() => CreateTodoPresenter(injector.get()));
  }
}
