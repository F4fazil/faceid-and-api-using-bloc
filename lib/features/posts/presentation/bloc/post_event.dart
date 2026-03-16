abstract class PostEvent {}

class FetchPostsEvent extends PostEvent {}

class RefreshPostsEvent extends PostEvent {}

class DeletePostsEvent extends PostEvent {
  final int postId;

  DeletePostsEvent({required this.postId});
}

class ArchivePostsEvent extends PostEvent {
  final int postId;

  ArchivePostsEvent({required this.postId});
}
