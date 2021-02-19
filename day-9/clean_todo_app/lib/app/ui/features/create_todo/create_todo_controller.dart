import 'package:clean_todo_app/app/ui/features/create_todo/create_todo_presenter.dart';
import 'package:clean_todo_app/app/ui/features/create_todo/create_todo_state.dart';
import 'package:clean_todo_app/data/requests/create_todo_request.dart';
import 'package:clean_todo_app/domain/requests/create_todo_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreateTodoController extends Controller {
  final CreateTodoPresenter _presenter;

  CreateTodoController(this._presenter);

  CreateTodoState _state = IdleCreateTodoState();
  CreateTodoState get state => _state;
  set state(CreateTodoState currentState) {
    if (currentState != null && currentState != _state) {
      _state = currentState;
      refreshUI();
    }
  }

  void createTodo(String task) {
    state = LoadingCreateTodoState();

    final CreateTodoRequest request =
        CreateTodoRequestImpl(task: task, status: false);

    _presenter.createTodo(request);
  }

  @override
  void initListeners() {
    _presenter.onComplete = () {
      state = IdleCreateTodoState();
    };
    _presenter.onError = (e) {
      print(e);

      if (e is DioError) {
        state = ErrorCreateTodoState(message: e.response.data["data"]);
      } else {
        state = ErrorCreateTodoState(message: e.toString());
      }
    };
    _presenter.onSuccess = (todo) {
      state = SuccessCreateTodoState();
    };
  }
}
