import 'package:clean_todo_app/app/di/app_container.dart';
import 'package:clean_todo_app/app/ui/features/create_todo/create_todo_page.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_controller.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TodosPage extends View {
  @override
  State<StatefulWidget> createState() =>
      _TodosPageView(AppContainer.injector.get());
}

class _TodosPageView extends ViewState<TodosPage, TodosController> {
  final TodosController _controller;

  _TodosPageView(this._controller) : super(_controller);

  Widget get view => Scaffold(
        appBar: AppBar(
          title: Text("Clean Arhictecture"),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                splashRadius: 24,
                onPressed: _controller.fetchAllTodos),
            IconButton(
                icon: Icon(Icons.add),
                splashRadius: 24,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateTodoPage()));
                }),
          ],
        ),
        body: ControlledWidgetBuilder<TodosController>(
          builder: (context, controller) {
            final state = controller.state;

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
