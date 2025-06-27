import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'user_name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔹 Post Image
          Image.asset(
            'assets/images/bg.jpg', // 👈 Replace with your image asset
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(height: 8),

          // 🔹 Action bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.favorite_border, size: 24),
                    SizedBox(width: 14),
                    Icon(Icons.notes, size: 26),
                    SizedBox(width: 14),
                    Icon(Icons.arrow_outward_rounded, size: 26),
                  ],
                ),
                const Icon(Icons.bookmark_border),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 🔹 Likes
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Liked by amit_g_101 and others',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '12,23,887',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 🔹 Caption
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'User_name  ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: 'A cracking start to the '),
                  TextSpan(
                    text: '#ENGvIND ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(text: 'series at Headingley 😆'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 6),

          // 🔹 Timestamp
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '2 minutes ago',
              // style: TextStyle(color: Colors.white, fontSize: 12),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
