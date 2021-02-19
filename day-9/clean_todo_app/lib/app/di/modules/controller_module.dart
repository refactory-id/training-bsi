import 'package:clean_todo_app/app/ui/features/todos/todos_controller.dart';
import 'package:injector/injector.dart';

class ControllerModule {
  static inject(Injector injector) {
    injector.registerSingleton(() => TodosController(injector.get()));
  }
}
