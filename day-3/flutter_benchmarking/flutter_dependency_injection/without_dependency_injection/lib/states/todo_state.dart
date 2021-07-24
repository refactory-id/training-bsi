import 'package:without_dependency_injection/models/todo_model.dart';
import 'package:without_dependency_injection/states/base_state.dart';

class SuccessGetAllTodo extends Success {
  final List<TodoModel>? data;
  SuccessGetAllTodo(this.data);
}

class SuccessCreateTodo extends Success {
  final TodoModel? data;
  SuccessCreateTodo(this.data);
}

class SuccessGetTodoById extends Success {
  final TodoModel? data;
  SuccessGetTodoById(this.data);
}

class SuccessUpdateTodoById extends Success {
  final TodoModel? data;
  SuccessUpdateTodoById(this.data);
}

class SuccessDeleteTodoById extends Success {
  final TodoModel? data;
  SuccessDeleteTodoById(this.data);
}
