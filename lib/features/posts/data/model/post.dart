class Post {
  final int id;
  final int UserId;
  final String title;
  final String? body;
  Post({
    required this.id,
    required this.UserId,
    required this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      UserId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
