import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/ui/features/create_todo/create_todo_cubit.dart';
import 'package:todo_app/app/ui/features/create_todo/create_todo_state.dart';
import 'package:todo_app/app/ui/features/todos/todos_cubit.dart';

class CreateTodoPage extends StatelessWidget {
  final _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<TodosCubit>().fetchAllTodos();
        
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create a new Todo"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _taskController,
              ),
            ),
            BlocConsumer<CreateTodoCubit, CreateTodoState>(
              builder: (context, state) {
                if (state is IdleCreateTodoState) {
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<CreateTodoCubit>()
                          .createTodo(_taskController.text);
                    },
                    child: Text(
                      "Create a new Todo",
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }
              },
              listener: (context, state) {
                if (state is SuccessCreateTodoState) {
                  Navigator.pop(context);

                  context.read<TodosCubit>().fetchAllTodos();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
