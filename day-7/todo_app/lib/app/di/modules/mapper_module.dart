import 'package:injector/injector.dart';
import 'package:todo_app/data/mappers/todo_mapper.dart';
import 'package:todo_app/usecase/mappers/todo_mapper.dart';

class MapperModule {
  static inject(Injector injector) {
    injector.registerSingleton<TodoMapper>(() => TodoMapperImpl());
  }
}
