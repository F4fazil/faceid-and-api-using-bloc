import 'dart:convert';
import 'package:faceid/features/posts/data/model/post.dart';
import 'package:http/http.dart' as http;

class PostApiService {
  Future<List<Post>> getPosts({int start = 0, int limit = 5}) async {
    final response = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit",
      ),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
