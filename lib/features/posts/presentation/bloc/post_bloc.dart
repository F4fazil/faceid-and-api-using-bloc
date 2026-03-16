import 'package:faceid/features/posts/data/model/post.dart';
import 'package:faceid/features/posts/data/respository/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;
  int currentstart = 0;
  int batchSize = 5;

  PostBloc(this.repository) : super(PostInitialState()) {
    //function to call api and emit states
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoadingState());

      try {
        currentstart = 0;
        final posts = await repository.apiService.getPosts(
          start: currentstart,
          limit: batchSize,
        );
        currentstart += posts.length;
        emit(PostLoadedState(posts: posts, archivedPosts: []));
      } catch (e) {
        emit(PostErrorState(message: "Failed to fetch posts"));
      }
    });

    on<RefreshPostsEvent>((event, emit) async {
      final currentposts = state is PostLoadedState
          ? (state as PostLoadedState).posts
          : [];
      emit(
        PostLoadedState(posts: currentposts as List<Post>, archivedPosts: []),
      );
      try {
        final posts = await repository.apiService.getPosts(
          start: currentstart,
          limit: batchSize,
        );
        currentstart += posts.length;
        final updatedPosts = [...currentposts, ...posts] as List<Post>;
        emit(PostLoadedState(posts: updatedPosts, archivedPosts: []));
      } catch (e) {
        emit(PostErrorState(message: "Failed to refresh posts"));
      }
    });
    on<DeletePostsEvent>((event, emit) async {
      if (state is PostLoadedState) {
        final currentPosts = (state as PostLoadedState).posts;

        final updatedPosts = currentPosts
            .where((post) => post.id != event.postId)
            .toList();

        emit(PostLoadedState(posts: updatedPosts, archivedPosts: []));
      }
    });

    on<ArchivePostsEvent>((event, emit) {
      if (state is PostLoadedState) {
        final currentState = state as PostLoadedState;

        final updatedPosts = currentState.posts
            .where((p) => p.id != event.postId)
            .toList();

        final archivedPost = currentState.posts.firstWhere(
          (p) => p.id == event.postId,
        );

        final updatedArchive = [...currentState.archivedPosts, archivedPost];

        emit(
          PostLoadedState(posts: updatedPosts, archivedPosts: updatedArchive),
        );
      }
    });
  }
}
