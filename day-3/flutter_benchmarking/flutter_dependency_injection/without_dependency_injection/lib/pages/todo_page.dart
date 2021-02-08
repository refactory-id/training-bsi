import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:without_dependency_injection/main.dart';
import 'package:without_dependency_injection/models/todo_model.dart';
import 'package:without_dependency_injection/presenters/todo_presenter.dart';
import 'package:without_dependency_injection/repositories/todo_repository.dart';
import 'package:without_dependency_injection/services/api_service.dart';
import 'package:without_dependency_injection/services/todo_service.dart';
import 'package:without_dependency_injection/states/base_state.dart';
import 'package:without_dependency_injection/states/todo_state.dart';
import 'package:without_dependency_injection/views/todo_view.dart';
import 'package:without_dependency_injection/widgets/button_widget.dart';
import 'package:without_dependency_injection/widgets/text_input_widget.dart';
import 'package:without_dependency_injection/utils/view_util.dart';

class TodoPage extends StatefulWidget {
  static String route = "/todo_page";

  final int _id;

  TodoPage(this._id);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> implements TodoView {
  ViewState _state;
  set state(value) => setState(() => _state = value);
  TodoModel _todo;
  set todo(value) => setState(() => _todo = value);

  TodoPresenter _todoPresenter;

  final _controller = TextEditingController(text: "");
  set text(value) => setState(() => _controller.text = value);

  @override
  void didChangeDependencies() {
    final baseUrl = "https://online-course-todo.herokuapp.com/api/";
    final dio = Dio();

    dio.options.connectTimeout = 60 * 1000;
    dio.options.receiveTimeout = 60 * 1000;
    dio.options.baseUrl = baseUrl;

    dio.interceptors.add(LogInterceptor(
      requestBody: MyApp.isDebug,
      responseBody: MyApp.isDebug,
      requestHeader: MyApp.isDebug,
      responseHeader: MyApp.isDebug,
      request: MyApp.isDebug,
      error: MyApp.isDebug,
    ));

    final ApiService api = ApiServiceImpl(dio);
    final TodoService service = TodoServiceImpl(api);
    final TodoRepository repository = TodoRepositoryImpl(service);
    _todoPresenter = TodoPresenterImpl(repository, this);
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
                      _todo.task = _controller.text;
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
