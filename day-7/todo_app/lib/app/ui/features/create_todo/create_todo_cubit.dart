import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/ui/features/create_todo/create_todo_state.dart';
import 'package:todo_app/domain/requests/todo_request.dart';
import 'package:todo_app/domain/usecases/create_todo_use_case.dart';
import 'package:todo_app/usecase/requests/create_todo_request.dart';

class CreateTodoCubit extends Cubit<CreateTodoState> {
  final CreateTodoUseCase _useCase;

  CreateTodoCubit(this._useCase) : super(IdleCreateTodoState());

  void createTodo(String task) async {
    emit(LoadingCreateTodoState());

    try {
      final TodoRequest request =
          CreateTodoRequestImpl(status: false, task: task);
      await _useCase.execute(request);

      emit(SuccessCreateTodoState());
      emit(IdleCreateTodoState());
    } catch (e) {
      print(e);

      if (e is DioError) {
        emit(ErrorCreateTodoState(message: e.response.data["data"]));
      } else {
        emit(ErrorCreateTodoState(message: e.toString()));
      }
    }
  }
}
