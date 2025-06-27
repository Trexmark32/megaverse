import 'dart:developer' as console;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/core/routing/route_names.dart';
import 'package:megaverse/providers/auth_provider.dart';
import 'package:megaverse/services/network/web3auth_calls.dart';
import 'package:megaverse/widgets/post_widget.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendATransaction();
        },
        child: Icon(Icons.abc_outlined),
      ),
      extendBody: true,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/brand.png",
          height: 26,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return PostCard();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined, size: 26),
            label: "Gallery",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel_rounded, size: 26),
            label: "Auction",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, size: 26),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet, size: 26),
            label: "Wallet",
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        child: Column(
          children: [
            DrawerHeader(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("User Name"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "0x14b35sdff...142eB929CA", // TODO: Full address is overflowing in DrawerHEader
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        IconButton(
                          icon: Icon(Icons.copy, size: 20),
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(text: "Address"),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(title: Text('Get Balance'), onTap: getBalance),
            ListTile(title: Text('Get User Info'), onTap: getUserInfo),
            ListTile(title: Text('Get Address'), onTap: getAddress),
            ListTile(title: Text('Logout'), onTap: _logout),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await Web3AuthFlutter.logout();
      console.log("HomeScreen: Web3AuthFlutter.logout() successful.");
      ref.read(logoutVisibleProvider.notifier).state = false;
      ref.read(authProvider.notifier).setUnauthenticated();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.login);
    } on UserCancelledException {
      console.log("User cancelled.");
    } on UnKnownException {
      console.log("Unknown exception occurred");
    }
  }
}
