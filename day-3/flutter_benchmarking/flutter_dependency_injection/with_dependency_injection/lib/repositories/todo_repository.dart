import 'package:with_dependency_injection/models/todo_model.dart';
import 'package:with_dependency_injection/services/todo_service.dart';
import 'package:with_dependency_injection/main.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getAllTodo();
  Future<TodoModel> getTodoById(int id);
  Future<TodoModel> deleteTodoById(int id);
  Future<TodoModel> createTodo(Map<String, dynamic> body);
  Future<TodoModel> updateTodoById(int id, Map<String, dynamic> body);
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoService _service;

  TodoRepositoryImpl(this._service);

  @override
  Future<TodoModel> createTodo(Map<String, dynamic> body) async {
    try {
      final response = await _service.createTodo(body);
      return TodoModel.fromJson(response["data"]);
    } catch (e) {
      if (MyApp.isDebug) print(e);
      return null;
    }
  }

  @override
  Future<TodoModel> deleteTodoById(int id) async {
    try {
      final response = await _service.deleteTodoById(id);
      return TodoModel.fromJson(response["data"]);
    } catch (e) {
      if (MyApp.isDebug) print(e);
      return null;
    }
  }

  @override
  Future<List<TodoModel>> getAllTodo() async {
    try {
      final todos = <TodoModel>[];
      final response = await _service.getAllTodo();

      response["data"]
          ?.forEach((object) => todos.add(TodoModel.fromJson(object)));

      return todos;
    } catch (e) {
      if (MyApp.isDebug) print(e);
      return null;
    }
  }

  @override
  Future<TodoModel> getTodoById(int id) async {
    try {
      final response = await _service.getTodoById(id);
      return TodoModel.fromJson(response["data"]);
    } catch (e) {
      if (MyApp.isDebug) print(e);
      return null;
    }
  }

  @override
  Future<TodoModel> updateTodoById(int id, Map<String, dynamic> body) async {
    try {
      final response = await _service.updateTodoById(id, body);
      return TodoModel.fromJson(response["data"]);
    } catch (e) {
      if (MyApp.isDebug) print(e);
      return null;
    }
  }
}
