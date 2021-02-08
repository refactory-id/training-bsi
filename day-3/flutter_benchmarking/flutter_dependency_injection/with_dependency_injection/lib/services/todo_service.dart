import 'package:with_dependency_injection/services/api_service.dart';

abstract class TodoService {
  Future<Map<String, dynamic>> getAllTodo();
  Future<Map<String, dynamic>> getTodoById(int id);
  Future<Map<String, dynamic>> deleteTodoById(int id);
  Future<Map<String, dynamic>> createTodo(Map<String, dynamic> body);
  Future<Map<String, dynamic>> updateTodoById(
      int id, Map<String, dynamic> body);
}

class TodoServiceImpl implements TodoService {
  final ApiService _service;
  final String _route = "v1/todos";

  TodoServiceImpl(this._service);

  @override
  Future<Map<String, dynamic>> createTodo(Map<String, dynamic> body) {
    return _service.call(_route, RequestType.POST, body: body);
  }

  @override
  Future<Map<String, dynamic>> deleteTodoById(int id) {
    return _service.call("$_route/$id", RequestType.DELETE);
  }

  @override
  Future<Map<String, dynamic>> getAllTodo() {
    return _service.call(_route, RequestType.GET);
  }

  @override
  Future<Map<String, dynamic>> getTodoById(int id) {
    return _service.call("$_route/$id", RequestType.GET);
  }

  @override
  Future<Map<String, dynamic>> updateTodoById(
      int id, Map<String, dynamic> body) {
    return _service.call("$_route/$id", RequestType.PUT, body: body);
  }
}
