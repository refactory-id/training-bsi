import 'package:dio/dio.dart';
import 'package:todo_app/data/services/todo_service.dart';

class TodoServiceImpl implements TodoService {
  final Dio _dio;

  TodoServiceImpl(this._dio);

  @override
  Future<Response> createTodo(Map<String, dynamic> body) {
    return _dio.post("v1/todos", data: body);
  }

  @override
  Future<Response> getTodos() {
    return _dio.get("v1/todos");
  }
}
