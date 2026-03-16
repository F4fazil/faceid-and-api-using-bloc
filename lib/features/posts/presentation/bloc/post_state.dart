import 'package:faceid/features/posts/data/model/post.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<Post> posts;
  final List<Post> archivedPosts;

  PostLoadedState({required this.posts, required this.archivedPosts});
}

class PostErrorState extends PostState {
  final String message;
  PostErrorState({required this.message});
}
