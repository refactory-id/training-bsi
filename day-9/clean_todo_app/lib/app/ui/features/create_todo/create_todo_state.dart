import 'package:equatable/equatable.dart';

abstract class CreateTodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingCreateTodoState extends CreateTodoState {}

class ErrorCreateTodoState extends CreateTodoState {
  final String? message;

  ErrorCreateTodoState({this.message});

  @override
  List<Object?> get props => [message];
}

class SuccessCreateTodoState extends CreateTodoState {}

class IdleCreateTodoState extends CreateTodoState {}
