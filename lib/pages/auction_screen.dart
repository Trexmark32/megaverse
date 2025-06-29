import 'package:flutter/material.dart';
import 'package:megaverse/models/auction_post_model.dart';
import 'package:megaverse/widgets/custom_button.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<AuctionPostModel> mockReadyToBidPosts = [
    AuctionPostModel(
      id: '1',
      imageUrl: 'assets/images/bg.jpg',
      title: 'Sunset over the City',
      currentBid: 0.0,
      endTime: DateTime.now().add(const Duration(days: 1)),
      isOngoing: false,
      artistName: 'Artist One',
      monetizationEnabled: true,
      status: PostStatus.readyToBid,
    ),
    AuctionPostModel(
      id: '2',
      imageUrl: 'assets/images/bg2.jpg',
      title: 'Abstract Forms',
      currentBid: 0.0,
      endTime: DateTime.now().add(const Duration(days: 2)),
      isOngoing: false,
      artistName: 'Artist Two',
      monetizationEnabled: true,
      status: PostStatus.readyToBid,
    ),
  ];

  final List<AuctionPostModel> mockOngoingBidPosts = [
    AuctionPostModel(
      id: '3',
      imageUrl: 'assets/images/bg3.jpg',
      title: 'Forest Path',
      currentBid: 0.75,
      endTime: DateTime.now().add(const Duration(hours: 10)),
      isOngoing: true,
      artistName: 'Artist Three',
      monetizationEnabled: true,
      status: PostStatus.inBidding,
    ),
    AuctionPostModel(
      id: '4',
      imageUrl: 'assets/images/crab.jpg',
      title: 'Mountain View',
      currentBid: 1.2,
      endTime: DateTime.now().add(const Duration(hours: 20)),
      isOngoing: true,
      artistName: 'Artist Four',
      monetizationEnabled: true,
      status: PostStatus.inBidding,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        labelColor: Colors.white, // Selected tab text color
        unselectedLabelColor: Colors.white70, // Unselected tab text color
        indicatorColor: Colors.white, // Indicator line color
        tabs: const [
          Tab(text: 'Ready to Bid'),
          Tab(text: 'Ongoing Bids'),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostList(mockReadyToBidPosts, isReadyToBid: true),
          _buildPostList(mockOngoingBidPosts, isReadyToBid: false),
        ],
      ),
    );
  }

  Widget _buildPostList(
    List<AuctionPostModel> posts, {
    required bool isReadyToBid,
  }) {
    if (posts.isEmpty) {
      return const Center(
        child: Text(
          'No posts available.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).padding.bottom +
            kBottomNavigationBarHeight +
            16.0,
        left: 8.0,
        right: 8.0,
        top: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ), // Rounded corners for image
                  child: Image.asset(
                    post.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Artist: ${post.artistName}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                if (isReadyToBid) ...[
                  Text(
                    'Monetization Enabled: ${post.monetizationEnabled ? "Yes" : "No"}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'View Details',
                          onPressed: () {
                            // TODO: Implement View Details logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('View Details for ${post.title}'),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CustomButton(
                          text: 'Start Auction',
                          onPressed: () {
                            // TODO: Implement start auction logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Start Auction for ${post.title}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Text(
                    'Current Bid: ${post.currentBid} ETH',
                    style: const TextStyle(color: Colors.greenAccent),
                  ),
                  Text(
                    'Ends: ${post.endTime.toLocal().toString().split('.')[0]}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'View Details',
                          onPressed: () {
                            // TODO: Implement View Details logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('View Details for ${post.title}'),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CustomButton(
                          text: 'Place Bid',
                          onPressed: () {
                            // TODO: Implement bid logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Place Bid on ${post.title}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
