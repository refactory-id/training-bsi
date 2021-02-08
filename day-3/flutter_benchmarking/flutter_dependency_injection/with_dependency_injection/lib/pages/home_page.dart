import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:with_dependency_injection/utils/view_util.dart';
import 'package:with_dependency_injection/models/todo_model.dart';
import 'package:with_dependency_injection/pages/todo_page.dart';
import 'package:with_dependency_injection/states/base_state.dart';
import 'package:with_dependency_injection/states/todo_state.dart';
import 'package:with_dependency_injection/views/todo_view.dart';
import 'package:with_dependency_injection/di/app_component.dart';
import 'package:with_dependency_injection/presenters/todo_presenter.dart';
import 'package:with_dependency_injection/widgets/button_widget.dart';
import 'package:with_dependency_injection/widgets/text_input_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState(AppComponent.injector.get<TodoPresenterImpl>());
}

class _HomePageState extends State<HomePage> implements TodoView {
  ViewState _state;
  set state(value) => setState(() => _state = value);
  List<TodoModel> _todos = [];
  set todos(value) => setState(() => _todos = value);
  TodoPresenter _todoPresenter;

  _HomePageState(TodoPresenterImpl todoPresenterImpl) {
    todoPresenterImpl.view = this;
    _todoPresenter = todoPresenterImpl;
  }

  final _controller = TextEditingController(text: "");

  @override
  void didChangeDependencies() {
    _todoPresenter.getAllTodo();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter with Depedency Injection"),
      ),
      body: (_state is Loading)
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 16,
              ),
            )
          : Builder(
              builder: (context) => Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final todo = _todos[index];

                            return Row(
                              children: [
                                Checkbox(
                                  value: todo.status,
                                  onChanged: (value) {
                                    _todoPresenter.updateTodoById(
                                        todo.id, {"status": value});
                                  },
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(todo.task),
                                    subtitle: Text(
                                        DateFormat("EEEE, dd MMMM yyyy")
                                            .format(DateTime.parse(todo.date))),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, TodoPage.route,
                                          arguments: todo.id);
                                    },
                                  ),
                                ),
                                IconButton(
                                    padding: EdgeInsets.all(8),
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      _todoPresenter.deleteTodoById(todo.id);
                                    })
                              ],
                            );
                          },
                          itemCount: _todos.length,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child:
                                  TextInputWidget("Create todo", _controller)),
                          ButtonWidget("Submit", () {
                            if (_controller.text.isNotEmpty) {
                              _todoPresenter.createTodo({
                                "task": _controller.text,
                              });
                            } else {
                              context.showSnackbar("Todo can't be empty!");
                            }
                          }),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      )
                    ],
                  )),
    );
  }

  @override
  void updateState(ViewState viewState) {
    state = viewState;

    if (viewState is Error) {
      context.showSnackbar(viewState.error);
    }

    if (viewState is Success) {
      if (viewState is SuccessGetAllTodo) {
        if (viewState.data != null) todos = viewState.data;
      } else if (viewState is SuccessUpdateTodoById) {
        if (viewState.data != null) {
          setState(() {
            final index = _todos.indexWhere((e) => e.id == viewState.data.id);
            if (index != -1) _todos[index] = viewState.data;
          });
        }
      } else if (viewState is SuccessDeleteTodoById) {
        if (viewState.data != null) {
          setState(() {
            final index = _todos.indexWhere((e) => e.id == viewState.data.id);
            if (index != -1) _todos.removeAt(index);
          });
        }
      } else if (viewState is SuccessCreateTodo) {
        _controller.text = "";

        if (viewState.data != null) {
          setState(() {
            _todos.insert(0, viewState.data);
          });
        }
      }
    }
  }
}
