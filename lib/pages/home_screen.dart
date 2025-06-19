import 'dart:developer' as console;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/core/routing/route_names.dart';
import 'package:megaverse/providers/auth_provider.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Megaverse Home')),
      body: Center(
        child: Column(
          children: [
            Text('Welcome!'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              onPressed: _logout,
              child: Column(children: [Text('Logout')]),
            ),
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
      ref.read(authProvider.notifier).state = false;
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.login);
    } on UserCancelledException {
      console.log("User cancelled.");
    } on UnKnownException {
      console.log("Unknown exception occurred");
    }
  }
}
