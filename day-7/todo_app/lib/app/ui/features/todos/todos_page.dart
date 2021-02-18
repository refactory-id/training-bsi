import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/ui/features/create_todo/create_todo_page.dart';
import 'package:todo_app/app/ui/features/todos/todos_cubit.dart';
import 'package:todo_app/app/ui/features/todos/todos_state.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TodosCubit>().fetchAllTodos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Clean Arhictecture"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              splashRadius: 24,
              onPressed: context.read<TodosCubit>().fetchAllTodos),
          IconButton(
              icon: Icon(Icons.add),
              splashRadius: 24,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CreateTodoPage()));
              }),
        ],
      ),
      body: BlocBuilder<TodosCubit, TodoState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(todo.task),
                );
              },
            );
          } else if (state is EmptyTodosState) {
            return Center(
              child: Text("Todo list Anda kosong"),
            );
          } else if (state is ErrorState) {
            return ListTile(
              title: Text(state.message),
              leading: Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
