import 'package:dio/dio.dart';

abstract class TodoService {
  Future<Response> getTodos();
  Future<Response> createTodo(Map<String, dynamic> body);
}
