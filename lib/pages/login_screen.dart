import 'dart:developer' as console;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Curve;
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:flutter_svg/svg.dart';
import 'package:megaverse/core/config/app_config.dart';
import 'package:megaverse/core/routing/route_names.dart';
import 'package:megaverse/pages/web_view.dart';
import 'package:megaverse/providers/auth_provider.dart';
import 'package:megaverse/widgets/email_phone_toggle_widget.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    console.log("LoginScreen: Building LoginScreen widget");
    final config = ref.watch(appConfigProvider);
    console.log("LoginScreen: After reading appConfigProvider");

    return Scaffold(
      backgroundColor: const Color(0xFF1A1D29), // dark background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 42),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  width: 360,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12141D),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white30, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(width: 16),
                          Image.asset("assets/images/brand.png", height: 36),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: Colors.white30),
                      const SizedBox(height: 16),

                      _buildLoginOption(
                        label: "MetaMask",
                        assetUrl: config.metamaskLoginIconUrl,
                        onPressed: () {
                          // call trust wallet login logic
                          // ref.invalidate(authProvider); // Refresh auth state
                        },
                      ),
                      _buildLoginOption(
                        label: "Trust Wallet",
                        assetUrl: config.trustWalletLoginIconUrl,
                        onPressed: () {
                          // call trust wallet login logic
                          // ref.invalidate(authProvider); // Refresh auth state
                        },
                      ),
                      _buildLoginOption(
                        label: "Argent",
                        assetUrl: config.argentLoginIconUrl,
                        onPressed: () {
                          // call trust wallet login logic
                          // ref.invalidate(authProvider); // Refresh auth state
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _socialLoginIconButton(
                            assetUrl: config.googleLoginIconUrl,
                            onPressed: () {
                              // Assign the callback returned by _login to onPressed
                              // _login itself needs ref, so we call it within this new lambda
                              _login(ref, _withGoogle)();
                            },
                          ),
                          const SizedBox(width: 4),
                          _socialLoginIconButton(
                            assetUrl: config.appleLoginIconUrl,
                            onPressed: () {},
                            iconColor: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          _socialLoginIconButton(
                            assetUrl: config.facebookLoginIconUrl,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 4),
                          _socialLoginIconButton(
                            assetUrl: config.twitterLoginIconUrl,
                            onPressed: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: Colors.white30),
                      const SizedBox(height: 16),

                      EmailPhoneInputSwitcher(
                        onSubmit: (value) {
                          // console.log("Email/Phone submitted: $value");
                          // ref.invalidate(authProvider);
                        },
                      ),

                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          children: [
                            const TextSpan(
                              text: "By signing in, you agree to our\n",
                            ),
                            TextSpan(
                              text: "Terms of Service",
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _openWebView(
                                  context,
                                  "Terms of Service",
                                  "https://example.com/terms",
                                ),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _openWebView(
                                  context,
                                  "Privacy Policy",
                                  "https://example.com/privacy",
                                ),
                            ),
                            const TextSpan(text: "."),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Powered by MetaMask",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlinedButton _socialLoginIconButton({
    required String assetUrl,
    ColorFilter? iconColor,
    VoidCallback? onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white12),
        minimumSize: const Size(18, 48),
      ),
      child: SvgPicture.network(
        assetUrl,
        height: 26,
        width: 26,
        colorFilter: iconColor,
        placeholderBuilder: (BuildContext context) => const SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        // Add error builder for SvgPicture.network
        // Note: SvgPicture.network itself doesn't have a direct errorBuilder like Image.network.
        // For robust SVG error handling, you might need to pre-fetch and then use SvgPicture.string
        // or handle errors at a higher level if the library doesn't support it directly.
        // For simplicity, we'll rely on the placeholder or a general network error message.
      ),
    );
  }

  Widget _buildLoginOption({
    required String label,
    required String assetUrl,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white12),
          minimumSize: const Size(double.infinity, 48),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Image.network(
              assetUrl,
              height: 26,
              width: 26,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 26,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openWebView(BuildContext context, String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(title: title, url: url),
      ),
    );
  }

  VoidCallback _login(
    WidgetRef ref,
    Future<Web3AuthResponse> Function() method,
  ) {
    return () async {
      console.log("LoginScreen: _login - START");
      try {
        ref.read(authProvider.notifier).setLoading();
        final Web3AuthResponse response = await method();
        console.log(
          "LoginScreen: _login - Method successful. Response SessionId: ${response.sessionId}, PrivKey: ${response.privKey?.isNotEmpty ?? false}",
        );
        // Check if widget is still mounted before updating state
        if (!ref.context.mounted) {
          console.log(
            "LoginScreen: _login - Context not mounted. Aborting state update.",
          );
          return;
        }
        // Correctly update the StateProvider
        ref.read(logoutVisibleProvider.notifier).state = true;
        console.log("LoginScreen: _login - logoutVisibleProvider set to true.");
        // Invalidate authProvider to re-trigger auth state check if needed
        // ref.read(authProvider.notifier).state = true;
        ref.read(authProvider.notifier).setAuthenticated();
        console.log("LoginScreen: _login - authProvider invalidated. END");
        Navigator.pushReplacementNamed(ref.context, RouteNames.home);
      } on UserCancelledException {
        console.log("LoginScreen: _login - User cancelled. END");
        // Optionally, handle UI feedback for cancellation
        ref.read(authProvider.notifier).setUnauthenticated();
      } on UnKnownException {
        console.log("LoginScreen: _login - Unknown exception occurred. END");
        ref.read(authProvider.notifier).setUnauthenticated();
      }
    };
  }

  Future<Web3AuthResponse> _withGoogle() async {
    try {
      final Web3AuthResponse response = await Web3AuthFlutter.login(
        LoginParams(
          loginProvider: Provider.google,
          mfaLevel: MFALevel.OPTIONAL,
          curve: Curve.secp256k1,
        ),
      );
      console.log(
        "LoginScreen: _withGoogle - Login successful. Response: ${response.toJson()}",
      );
      return response;
    } catch (e) {
      console.log(
        "LoginScreen: _withGoogle - Error during Web3AuthFlutter.login: $e",
      );
      // Handle the error as needed
      // You might want to show a user-friendly message or log the error
      // Re-throw the error so it's caught by the _login method's try-catch
      rethrow;
    }
  }
}
