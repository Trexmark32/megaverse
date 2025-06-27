// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  String profileIconUrl;
  String userName;
  String postImageUrl;
  int likeCount;
  int commentCount;
  String caption;
  String timeStamp;

  PostModel({
    required this.profileIconUrl,
    required this.userName,
    required this.postImageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.caption,
    required this.timeStamp,
  });
}
