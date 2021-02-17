import 'package:todo_app/domain/requests/todo_request.dart';

abstract class CreateTodoRequest extends TodoRequest {
  String task;
  bool status;
}
