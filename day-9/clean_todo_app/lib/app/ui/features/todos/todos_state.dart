import 'package:clean_todo_app/domain/entities/todo_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmptyTodosState extends TodoState {}

class LoadingState extends TodoState {}

class ErrorState extends TodoState {
  final String? message;

  ErrorState({this.message});

  @override
  List<Object?> get props => [message];
}

class LoadedState extends TodoState {
  final List<Todo>? todos;

  LoadedState({this.todos});

  @override
  List<Object?> get props => [todos];
}
