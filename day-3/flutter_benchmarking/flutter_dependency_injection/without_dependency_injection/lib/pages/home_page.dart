import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:without_dependency_injection/main.dart';
import 'package:without_dependency_injection/utils/view_util.dart';
import 'package:without_dependency_injection/models/todo_model.dart';
import 'package:without_dependency_injection/pages/todo_page.dart';
import 'package:without_dependency_injection/presenters/todo_presenter.dart';
import 'package:without_dependency_injection/repositories/todo_repository.dart';
import 'package:without_dependency_injection/services/api_service.dart';
import 'package:without_dependency_injection/services/todo_service.dart';
import 'package:without_dependency_injection/states/base_state.dart';
import 'package:without_dependency_injection/states/todo_state.dart';
import 'package:without_dependency_injection/views/todo_view.dart';
import 'package:without_dependency_injection/widgets/button_widget.dart';
import 'package:without_dependency_injection/widgets/text_input_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements TodoView {
  late ViewState _state;
  set state(value) => setState(() => _state = value);
  List<TodoModel> _todos = [];
  set todos(value) => setState(() => _todos = value);
  late TodoPresenter _todoPresenter;

  final _controller = TextEditingController(text: "");

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
    _todoPresenter.getAllTodo();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter without Depedency Injection"),
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
        final data = viewState.data;
        if (data != null) {
          setState(() {
            final index = _todos.indexWhere((e) => e.id == data.id);
            if (index != -1) _todos[index] = data;
          });
        }
      } else if (viewState is SuccessDeleteTodoById) {
        final data = viewState.data;
        if (data != null) {
          setState(() {
            final index = _todos.indexWhere((e) => e.id == data.id);
            if (index != -1) _todos.removeAt(index);
          });
        }
      } else if (viewState is SuccessCreateTodo) {
        final data = viewState.data;
        _controller.text = "";

        if (data != null) {
          setState(() {
            _todos.insert(0, data);
          });
        }
      }
    }
  }
}
