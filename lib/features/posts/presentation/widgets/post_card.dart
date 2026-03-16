import 'package:faceid/features/posts/data/model/post.dart';
import 'package:faceid/features/posts/presentation/bloc/post_bloc.dart';
import 'package:faceid/features/posts/presentation/bloc/post_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // actions when swiping right → left
      endActionPane: ActionPane(
        motion: const DrawerMotion(),

        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<PostBloc>().add(ArchivePostsEvent(postId: post.id));
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),

          SlidableAction(
            onPressed: (context) {
              context.read<PostBloc>().add(DeletePostsEvent(postId: post.id));
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: Card(
        shadowColor: Colors.grey.shade300,
        surfaceTintColor: Colors.yellow,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(post.body ?? "No description"),
            ],
          ),
        ),
      ),
    );
  }
}
