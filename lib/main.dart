import 'dart:developer' as console;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/auth_redirector.dart';
import 'package:megaverse/core/routing/app_router.dart';
import 'package:megaverse/core/theme/app_theme.dart';

import 'services/auth/setup_web3auth_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load environment variables, but don't fail if .env doesn't exist
  try {
    await dotenv.load(fileName: ".env");
    console.log("Environment variables loaded successfully");
  } catch (e) {
    console.log("Warning: Could not load .env file: $e");
    console.log("Continuing with default values...");
  }

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAuth();
    });
  }

  Future<void> _initAuth() async {
    try {
      await setupWeb3Auth(ref);
      console.log("main.dart: _initAuth - Web3Auth setup complete.");
    } catch (e, stack) {
      debugPrint('Error during app initialization: $e\n$stack');
      console.log('Error during app initialization: $e\n$stack');
    } finally {
      FlutterNativeSplash.remove();
      console.log("main.dart: _initAuth - Native splash removed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Megaverse',
      navigatorKey: navigatorKey,
      onGenerateRoute: generateRoute,
      home: AuthRedirector(),
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
