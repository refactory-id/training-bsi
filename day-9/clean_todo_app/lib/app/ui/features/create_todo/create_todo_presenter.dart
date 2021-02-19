import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:clean_todo_app/domain/requests/todo_request.dart';
import 'package:clean_todo_app/domain/usecases/create_todo_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreateTodoPresenter extends Presenter {
  final CreateTodoUseCase _useCase;

  Function onComplete;
  Function(dynamic error) onError;
  Function(Todo todo) onSuccess;

  CreateTodoPresenter(this._useCase);

  void createTodo(TodoRequest todoRequest) {
    _useCase.execute(_CreateTodoObserver(this), todoRequest);
  }

  @override
  void dispose() {
    _useCase.dispose();
  }
}

class _CreateTodoObserver extends Observer<Todo> {
  final CreateTodoPresenter _presenter;

  _CreateTodoObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.onComplete();
  }

  @override
  void onError(e) {
    _presenter.onError(e);
  }

  @override
  void onNext(Todo response) {
    _presenter.onSuccess(response);
  }
}
