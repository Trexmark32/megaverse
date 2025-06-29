enum PostStatus {
  inPost,
  readyToBid,
  inBidding,
  postSold,
}

class AuctionPostModel {
  final String id;
  final String imageUrl;
  final String title;
  final double currentBid;
  final DateTime endTime;
  final bool isOngoing;
  final String artistName;
  final bool monetizationEnabled;
  final PostStatus status;

  AuctionPostModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.currentBid,
    required this.endTime,
    required this.isOngoing,
    required this.artistName,
    required this.monetizationEnabled,
    required this.status,
  });
}
