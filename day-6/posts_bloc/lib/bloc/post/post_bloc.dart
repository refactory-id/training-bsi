import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/bloc/post/post_event.dart';
import 'package:posts_bloc/bloc/post/post_state.dart';
import 'package:posts_bloc/model/post_model.dart';

class PostBloc extends Bloc<GetPostsEvent, PostState> {
  final Dio _dio;

  PostBloc(this._dio) : super(PostLoadingState());

  @override
  Stream<PostState> mapEventToState(GetPostsEvent event) async* {
    if (state is! PostLoadingState) {
      yield PostLoadingState();
    }

    try {
      // https://jsonplaceholder.typicode.com/posts
      final response = await _dio.get("posts");
      final posts = <Post>[];

      response.data.forEach((json) {
        posts.add(Post.fromJson(json));
      });

      yield PostSuccessState();

      await Future.delayed(Duration(seconds: 1));

      if (posts.isNotEmpty) {
        yield LoadedPostState(posts: posts);
      } else {
        yield EmptyPostState();
      }
    } catch (e) {
      print(e);

      if (e is DioError) {
        yield PostErrorState(message: e.response.statusMessage);
      } else {
        yield PostErrorState(
            message: e.toString() ?? "Oops something went wrong");
      }
    }
  }
}
