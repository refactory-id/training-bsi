import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_bloc/bloc/post/post_bloc.dart';
import 'package:posts_bloc/bloc/post/post_event.dart';
import 'package:posts_bloc/bloc/post/post_state.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(GetPostsEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter BLoC"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<PostBloc>().add(GetPostsEvent()),
            splashRadius: 24,
          )
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is LoadedPostState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];

                return ListTile(
                  contentPadding: EdgeInsets.all(8),
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          } else if (state is PostSuccessState) {
            return Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 48,
              ),
            );
          } else if (state is PostErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_sharp,
                    color: Colors.red,
                    size: 48,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(state.message),
                  )
                ],
              ),
            );
          } else if (state is EmptyPostState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text("Oops data post kosong"),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
      ),
    );
  }
}
