import 'package:flutter/material.dart';
import 'package:megaverse/widgets/post_widget.dart';

class PostFeedScreen extends StatelessWidget {
  const PostFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        // Use Builder to get a context that has MediaQuery
        builder: (BuildContext innerContext) {
          return ListView.builder(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(innerContext).padding.bottom +
                  kBottomNavigationBarHeight +
                  16.0,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return PostCard();
            },
          );
        },
      ),
    );
  }
}
