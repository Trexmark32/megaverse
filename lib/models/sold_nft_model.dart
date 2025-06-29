class SoldNFTModel {
  final String id;
  final String imageUrl;
  final String title;
  final double price;
  final String winnerName;
  final String nftContractAddress;
  final String tokenId;

  SoldNFTModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.winnerName,
    required this.nftContractAddress,
    required this.tokenId,
  });
}
