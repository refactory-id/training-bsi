import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/ui/features/todos/todos_state.dart';
import 'package:todo_app/domain/usecases/get_todos_use_case.dart';

class TodosCubit extends Cubit<TodoState> {
  final GetTodosUseCase _useCase;

  TodosCubit(this._useCase) : super(LoadingState());

  void increment() {
    final currentState = state;

    if (currentState is LoadedState) {
      final counter = currentState.counter + 1;
      emit(currentState.copy(counter: counter));
    }
  }

  void fetchAllTodos() async {
    if (state is! LoadingState) {
      emit(LoadingState());
    }

    try {
      final todos = await _useCase.execute();

      emit(todos.isNotEmpty
          ? LoadedState(todos: todos, counter: 0)
          : EmptyTodosState());
    } catch (e) {
      print(e);

      if (e is DioError) {
        emit(ErrorState(message: e.response.data["data"]));
      } else {
        emit(ErrorState(message: e.toString()));
      }
    }
  }
}
