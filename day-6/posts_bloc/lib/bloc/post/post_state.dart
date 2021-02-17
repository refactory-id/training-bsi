import 'package:equatable/equatable.dart';
import 'package:posts_bloc/model/post_model.dart';

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostState {}

class PostErrorState extends PostState {
  final String message;

  PostErrorState({this.message});

  @override
  List<Object> get props => [message];
}

class EmptyPostState extends PostState {}

class PostSuccessState extends PostState {}

class LoadedPostState extends PostState {
  final List<Post> posts;

  LoadedPostState({this.posts});

  @override
  List<Object> get props => [posts];
}
