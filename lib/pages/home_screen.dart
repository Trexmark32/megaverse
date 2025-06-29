import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/core/routing/route_names.dart';
import 'package:megaverse/pages/add_post_screen.dart';
import 'package:megaverse/pages/auction_screen.dart';
import 'package:megaverse/pages/gallery_screen.dart';
import 'package:megaverse/pages/post_feed_screen.dart';
import 'package:megaverse/pages/profile_screen.dart';
import 'package:megaverse/services/auth/auth_service.dart'; // New import
import 'package:megaverse/widgets/custom_app_bar.dart';
import 'package:megaverse/widgets/custom_bottom_navigation_bar.dart';
import 'package:megaverse/widgets/custom_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    GalleryScreen(),
    const AuctionScreen(),
    const PostFeedScreen(),
    const AddPostScreen(),
    ProfileScreen(),
    // WalletScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(ref);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     sendATransaction();
      //   },
      //   child: Icon(Icons.abc_outlined),
      // ),
      extendBody: true,
      appBar: const CustomAppBar(),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      drawer: CustomDrawer(
        onLogout: () async {
          await authService.logout();
          Navigator.pushReplacementNamed(context, RouteNames.login);
        },
      ),
    );
  }
}
