import 'package:faceid/features/posts/presentation/screens/archived_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../widgets/post_card.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool showArchiveTile = false;
  @override
  Widget build(BuildContext context) {
    //feature screen to display posts using Bloc pattern
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                context.read<PostBloc>().add(RefreshPostsEvent());
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  showArchiveTile = true;
                });
                await Future.delayed(Duration(milliseconds: 500));
              },

              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  if (showArchiveTile && state.archivedPosts.isNotEmpty)
                    ListTile(
                      selectedColor: Colors.blue.shade100,
                      leading: Icon(Icons.archive),
                      title: Text("Archived"),
                      trailing: Text("${state.archivedPosts.length}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ArchivedScreen()),
                        );
                      },
                    ),
                  Divider(),

                  ...state.posts.map((post) => PostCard(post: post)),
                ],
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
