import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_dependency_injection/di/app_component.dart';
import 'package:with_dependency_injection/models/todo_model.dart';
import 'package:with_dependency_injection/presenters/todo_presenter.dart';
import 'package:with_dependency_injection/states/base_state.dart';
import 'package:with_dependency_injection/states/todo_state.dart';
import 'package:with_dependency_injection/views/todo_view.dart';
import 'package:with_dependency_injection/widgets/button_widget.dart';
import 'package:with_dependency_injection/widgets/text_input_widget.dart';
import 'package:with_dependency_injection/utils/view_util.dart';

class TodoPage extends StatefulWidget {
  static String route = "/todo_page";

  final int _id;

  TodoPage(this._id);

  @override
  _TodoPageState createState() =>
      _TodoPageState(AppComponent.injector.get<TodoPresenterImpl>());
}

class _TodoPageState extends State<TodoPage> implements TodoView {
  ViewState _state;
  set state(value) => setState(() => _state = value);
  TodoModel _todo;
  set todo(value) => setState(() => _todo = value);

  TodoPresenter _todoPresenter;

  final _controller = TextEditingController(text: "");
  set text(value) => setState(() => _controller.text = value);

  _TodoPageState(TodoPresenterImpl todoPresenterImpl) {
    todoPresenterImpl.view = this;
    _todoPresenter = todoPresenterImpl;
  }

  @override
  void didChangeDependencies() {
    _todoPresenter.getTodoById(widget._id);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Page with Depedency Injection"),
      ),
      body: (_state is Loading)
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 16,
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                TextInputWidget("Update todo", _controller),
                CheckboxListTile(
                  value: _todo.status,
                  onChanged: (value) => {setState(() => _todo.status = value)},
                  title: Text("is done?"),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.all(16),
                  child: ButtonWidget("Submit", () {
                    if (_controller.text.isNotEmpty) {
                      _todoPresenter.updateTodoById(_todo.id, _todo.toJson());
                    } else {
                      context.showSnackbar("Todo can't be empty!");
                    }
                  }),
                ),
              ],
            ),
    );
  }

  @override
  void updateState(ViewState viewState) {
    state = viewState;

    if (viewState is Success) {
      if (viewState is SuccessGetTodoById) {
        todo = viewState.data;
        text = viewState.data.task;
      } else if (viewState is SuccessUpdateTodoById) {
        todo = viewState.data;
        text = viewState.data.task;
      }
    }
  }
}
