import 'package:clean_todo_app/domain/requests/create_todo_request.dart';

class CreateTodoRequestImpl implements CreateTodoRequest {
  @override
  bool status;

  @override
  String task;

  CreateTodoRequestImpl({this.task, this.status});
}
