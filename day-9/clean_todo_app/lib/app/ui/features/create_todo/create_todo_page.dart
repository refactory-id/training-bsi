import 'package:clean_todo_app/app/di/app_container.dart';
import 'package:clean_todo_app/app/ui/features/create_todo/create_todo_controller.dart';
import 'package:clean_todo_app/app/ui/features/create_todo/create_todo_state.dart';
import 'package:clean_todo_app/app/ui/features/todos/todos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreateTodoPage extends View {
  @override
  State<StatefulWidget> createState() =>
      _CreateTodoPageView(AppContainer.injector.get());
}

class _CreateTodoPageView
    extends ViewState<CreateTodoPage, CreateTodoController> {
  final _taskController = TextEditingController();
  final CreateTodoController _controller;

  _CreateTodoPageView(this._controller) : super(_controller);

  @override
  Widget get view => WillPopScope(
        onWillPop: () async {
          AppContainer.injector.get<TodosController>().fetchAllTodos();

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
              ControlledWidgetBuilder<CreateTodoController>(
                builder: (context, controller) {
                  final state = controller.state;

                  if (state is IdleCreateTodoState) {
                    return ElevatedButton(
                      onPressed: () {
                        _controller.createTodo(_taskController.text);
                        AppContainer.injector
                            .get<TodosController>()
                            .fetchAllTodos();
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
              )
            ],
          ),
        ),
      );
}
