import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:clean_todo_app/domain/usecases/get_todos_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TodoPresenter extends Presenter {
  final GetTodosUseCase _useCase;

  Function(dynamic) onError;
  Function(List<Todo>) onSuccess;
  Function onComplete;

  TodoPresenter(this._useCase);

  void fetchAllTodos() {
    _useCase.execute(_TodoObserver(this));
  }

  @override
  void dispose() {
    _useCase.dispose();
  }
}

class _TodoObserver extends Observer<List<Todo>> {
  final TodoPresenter _presenter;

  _TodoObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.onComplete();
  }

  @override
  void onError(e) {
    _presenter.onError(e);
  }

  @override
  void onNext(List<Todo> response) {
    _presenter.onSuccess(response);
  }
}
