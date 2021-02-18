import 'package:injector/injector.dart';
import 'package:todo_app/app/ui/features/create_todo/create_todo_cubit.dart';
import 'package:todo_app/app/ui/features/todos/todos_cubit.dart';

class CubitModule {
  static inject(Injector injector) {
    injector.registerSingleton<TodosCubit>(() => TodosCubit(injector.get()));
    injector.registerSingleton<CreateTodoCubit>(
        () => CreateTodoCubit(injector.get()));
  }
}
