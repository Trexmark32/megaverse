import 'package:flutter/material.dart';
import 'package:megaverse/models/sold_nft_model.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final List<SoldNFTModel> mockSoldNFTs = [
    SoldNFTModel(
      id: '1',
      imageUrl: 'assets/images/app_icon.png',
      title: 'Abstract Art #1',
      price: 1.5,
      winnerName: 'Alice',
      nftContractAddress: '0xabcdef1234567890abcdef1234567890abcdef12',
      tokenId: '101',
    ),
    SoldNFTModel(
      id: '2',
      imageUrl: 'assets/images/bg.jpg',
      title: 'Digital Landscape',
      price: 0.8,
      winnerName: 'Bob',
      nftContractAddress: '0xabcdef1234567890abcdef1234567890abcdef12',
      tokenId: '102',
    ),
    SoldNFTModel(
      id: '3',
      imageUrl: 'assets/images/brand.png',
      title: 'Crypto Creature',
      price: 2.1,
      winnerName: 'Charlie',
      nftContractAddress: '0xabcdef1234567890abcdef1234567890abcdef12',
      tokenId: '103',
    ),
    SoldNFTModel(
      id: '4',
      imageUrl: 'assets/images/crab.jpg',
      title: 'Pixel Portrait',
      price: 0.5,
      winnerName: 'David',
      nftContractAddress: '0xabcdef1234567890abcdef1234567890abcdef12',
      tokenId: '104',
    ),
    SoldNFTModel(
      id: '5',
      imageUrl: 'assets/images/logo.png',
      title: 'Sci-Fi City',
      price: 3.0,
      winnerName: 'Eve',
      nftContractAddress: '0xabcdef1234567890abcdef1234567890abcdef12',
      tokenId: '105',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: mockSoldNFTs.length,
        itemBuilder: (context, index) {
          final nft = mockSoldNFTs[index];
          return Card(
            color: Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ), // Apply rounded corners
                    child: Image.asset(
                      nft.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nft.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Price: ${nft.price} ETH',
                        style: const TextStyle(color: Colors.greenAccent),
                      ),
                      Text(
                        'Winner: ${nft.winnerName}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        'Token ID: ${nft.tokenId}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
