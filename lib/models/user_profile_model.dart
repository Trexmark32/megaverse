class UserProfileModel {
  final String profileImageUrl;
  final String username;
  final String bio;
  final int postsCount;
  final int followersCount;
  final int followingCount;

  UserProfileModel({
    required this.profileImageUrl,
    required this.username,
    required this.bio,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });
}
