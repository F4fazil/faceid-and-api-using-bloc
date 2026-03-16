import 'package:faceid/features/posts/presentation/bloc/post_bloc.dart';
import 'package:faceid/features/posts/presentation/bloc/post_state.dart';
import 'package:faceid/features/posts/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PostBloc>().state as PostLoadedState;

    final archivedPosts = state.archivedPosts;

    return Scaffold(
      appBar: AppBar(title: Text("Archived")),
      body: ListView.builder(
        itemCount: archivedPosts.length,
        itemBuilder: (context, index) {
          return PostCard(post: archivedPosts[index]);
        },
      ),
    );
  }
}
