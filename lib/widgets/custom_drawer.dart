import 'package:flutter/material.dart';
import 'package:megaverse/core/routing/route_names.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const CustomDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "User Name",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              "user@example.com", // Placeholder for email, or can be empty
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/app_icon.png',
              ), // Using local asset
            ),
            decoration: BoxDecoration(color: Colors.grey[900]),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.wallet, color: Colors.white70),
                  title: const Text(
                    'My Wallet',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteNames.wallet);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white70),
                  title: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // TODO: Navigate to Settings Screen
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help_outline,
                    color: Colors.white70,
                  ),
                  title: const Text(
                    'Help & Support',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // TODO: Navigate to Help & Support Screen
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                // Other scrollable items can go here
              ],
            ),
          ),
          const Divider(color: Colors.white30),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white70),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: onLogout,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0, top: 8.0),
            child: Text(
              'App Version: 1.0.0', // Placeholder for app version
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
