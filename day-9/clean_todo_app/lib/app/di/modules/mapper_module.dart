import 'package:clean_todo_app/domain/mappers/todo_mapper.dart';
import 'package:injector/injector.dart';
import 'package:clean_todo_app/data/mappers/todo_mapper.dart';

class MapperModule {
  static inject(Injector injector) {
    injector.registerSingleton<TodoMapper>(() => TodoMapperImpl());
  }
}
