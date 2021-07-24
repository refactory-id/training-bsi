import 'package:dio/dio.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_presenter.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_state.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TodosController extends Controller {
  final TodoPresenter _presenter;

  TodosController(this._presenter);

  TodoState _state = LoadingState();
  TodoState get state => _state;
  set state(TodoState currentState) {
    if (_state != currentState) {
      _state = currentState;
      refreshUI();
    }
  }

  void fetchAllTodos() {
    state = LoadingState();

    _presenter.fetchAllTodos();
  }

  @override
  void initListeners() {
    _presenter.onComplete = () {};
    _presenter.onSuccess = (todos) {
      state = LoadedState(todos: todos);
    };
    _presenter.onError = (e) {
      print(e);

      if (e is DioError) {
        state = ErrorState(message: e.response!.data["data"]);
      } else {
        state = ErrorState(message: e.toString());
      }
    };

    fetchAllTodos();
  }
}
