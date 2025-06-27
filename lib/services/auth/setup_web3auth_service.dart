import 'dart:collection';
import 'dart:developer' as console;
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/providers/auth_provider.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

Future<void> setupWeb3Auth(WidgetRef ref) async {
  console.log("App reached: setupWeb3Auth");
  ref.read(authProvider.notifier).setLoading();
  bool sessionInitialized = false;
  final themeMap = HashMap<String, String>();
  themeMap['primary'] = "#4CDBD2";

  final redirectUrl = Platform.isAndroid
      ? Uri.parse('megapp://com.example.megaverse')
      : Uri.parse('com.example.megaverse://auth'); // for iOS
  console.log("Redirect URL: $redirectUrl");

  // Get client ID from environment or use a fallback for development
  String clientId = dotenv.env['WEB3AUTH_CLIENT_ID'] ?? '';
  if (clientId.isEmpty) {
    const String errorMessage =
        "WEB3AUTH_CLIENT_ID not found in .env file. Please add it.";
    console.log("Error: $errorMessage");
    // Throwing an exception is better than proceeding with an invalid client ID.
    throw Exception(errorMessage);
  } else {
    console.log("WEB3AUTH_CLIENT_ID: ${dotenv.env['WEB3AUTH_CLIENT_ID']}");
  }
  await Web3AuthFlutter.init(
    Web3AuthOptions(
      clientId: "${dotenv.env['WEB3AUTH_CLIENT_ID']}",
      network: Network.sapphire_devnet,
      redirectUrl: redirectUrl,
      whiteLabel: WhiteLabelData(
        appName: "Megaverse",
        logoLight: "assets/images/logo.png",
        logoDark: "assets/images/logo.png",
        defaultLanguage: Language.en,
        mode: ThemeModes.auto,
        appUrl: "https://web3auth.io",
        useLogoLoader: true,
        theme: themeMap,
      ),
    ),
  );
  console.log("Web3Auth init completed");
  try {
    await Web3AuthFlutter.initialize();
    sessionInitialized = true;
  } catch (e) {
    console.log("Error initializing Web3Auth: $e");
  }
  if (sessionInitialized) {
    final String res = await Web3AuthFlutter.getPrivKey();
    console.log("Private key from initialized session: $res");
    if (res.isNotEmpty) {
      console.log("Authenticated");
      // get user info and save and redirect to home screen
      ref.read(authProvider.notifier).setAuthenticated();
      // ref.read(authProvider.notifier).state = AsyncData(
      //   const AuthState(AuthStatus.authenticated),
      // );

      // ref.read(authProvider.notifier).state = true;
    } else {
      console.log(
        "Warning: Session initialized but no private key found. Proceeding to login.",
      );
      ref.read(authProvider.notifier).setUnauthenticated();
    }
  } else {
    console.log("No active session found. User needs to login.");
    ref.read(authProvider.notifier).setUnauthenticated();
  }
}
