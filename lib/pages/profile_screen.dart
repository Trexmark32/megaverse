import 'package:megaverse/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:megaverse/models/user_profile_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserProfileModel mockUserProfile = UserProfileModel(
    profileImageUrl: 'assets/images/app_icon.png',
    username: 'MegaUser',
    bio:
        'Digital artist and NFT enthusiast. Creating unique pieces for the metaverse.',
    postsCount: 120,
    followersCount: 5000,
    followingCount: 150,
  );

  final List<String> mockUserPosts = const [
    'assets/images/bg.jpg',
    'assets/images/brand.png',
    'assets/images/crab.jpg',
    'assets/images/logo.png',
    'assets/images/app_icon.png',
    'assets/images/bg.jpg',
    'assets/images/brand.png',
    'assets/images/crab.jpg',
    'assets/images/logo.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(mockUserProfile.username),
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.more_vert, color: Colors.white),
      //       onPressed: () {
      //         // TODO: Implement profile options
      //       },
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          mockUserProfile.profileImageUrl,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatColumn(
                              'Posts',
                              mockUserProfile.postsCount,
                            ),
                            _buildStatColumn(
                              'Followers',
                              mockUserProfile.followersCount,
                            ),
                            _buildStatColumn(
                              'Following',
                              mockUserProfile.followingCount,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    mockUserProfile.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mockUserProfile.bio,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Edit Profile',
                          onPressed: () {
                            // TODO: Implement Edit Profile
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomButton(
                          text: 'Share Profile',
                          onPressed: () {
                            // TODO: Implement Share Profile
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white30),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemCount: mockUserPosts.length,
              itemBuilder: (context, index) {
                return Image.asset(mockUserPosts[index], fit: BoxFit.cover);
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildStatColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
