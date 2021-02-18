import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/todo_entity.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyTodosState extends TodoState {}

class LoadingState extends TodoState {}

class ErrorState extends TodoState {
  final String message;

  ErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class LoadedState extends TodoState {
  final List<Todo> todos;
  final int counter;

  LoadedState({this.todos, this.counter});

  LoadedState copy({List<Todo> todos, int counter}) {
    return LoadedState(
      todos: todos ?? this.todos,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object> get props => [todos, counter];
}
