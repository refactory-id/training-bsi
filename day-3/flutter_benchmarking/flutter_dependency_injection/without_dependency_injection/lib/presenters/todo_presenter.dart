import 'package:without_dependency_injection/repositories/todo_repository.dart';
import 'package:without_dependency_injection/states/base_state.dart';
import 'package:without_dependency_injection/states/todo_state.dart';
import 'package:without_dependency_injection/views/todo_view.dart';

abstract class TodoPresenter {
  void getAllTodo();
  void getTodoById(int id);
  void deleteTodoById(int id);
  void createTodo(Map<String, dynamic> body);
  void updateTodoById(int id, Map<String, dynamic> body);
}

class TodoPresenterImpl extends TodoPresenter {
  final TodoRepository _repository;
  TodoView view;

  TodoPresenterImpl(this._repository, [this.view]);

  @override
  void createTodo(Map<String, dynamic> body) {
    _apiCall(() async {
      final data = await _repository.createTodo(body);
      view.updateState(SuccessCreateTodo(data));
    });
  }

  @override
  void deleteTodoById(int id) {
    _apiCall(() async {
      final data = await _repository.deleteTodoById(id);
      view.updateState(SuccessDeleteTodoById(data));
    });
  }

  @override
  void getAllTodo() {
    _apiCall(() async {
      final data = await _repository.getAllTodo();
      view.updateState(SuccessGetAllTodo(data));
    });
  }

  @override
  void getTodoById(int id) {
    _apiCall(() async {
      final data = await _repository.getTodoById(id);
      view.updateState(SuccessGetTodoById(data));
    });
  }

  @override
  void updateTodoById(int id, Map<String, dynamic> body) {
    _apiCall(() async {
      final data = await _repository.updateTodoById(id, body);
      view.updateState(SuccessUpdateTodoById(data));
    });
  }

  void _apiCall(Function function) {
    view.updateState(Loading());

    try {
      function();
    } catch (e) {
      view.updateState(Error(e?.message ?? "Oops something went wrong"));
    }
  }
}
