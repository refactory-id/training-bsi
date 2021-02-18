import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/di/app_container.dart';
import 'package:todo_app/app/ui/features/create_todo/create_todo_cubit.dart';
import 'package:todo_app/app/ui/features/todos/todos_cubit.dart';
import 'package:todo_app/app/ui/features/todos/todos_page.dart';

void main() {
  AppContainer.inject();

  final injector = AppContainer.injector;

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => injector.get<TodosCubit>()),
    BlocProvider(create: (_) => injector.get<CreateTodoCubit>())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodosPage(),
    );
  }
}
