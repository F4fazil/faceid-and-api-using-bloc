import 'package:faceid/features/posts/data/dataSource/post_apiService.dart';
import 'package:faceid/features/posts/data/model/post.dart';

class PostRepository {
  final PostApiService apiService;

  PostRepository(this.apiService);
  //wrapper function to call api service
  Future<List<Post>> fetchPosts({int start = 0, int limit = 5}) async {
    return await apiService.getPosts(start: start, limit: limit);
  }
}
