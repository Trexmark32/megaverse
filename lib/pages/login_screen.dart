import 'dart:developer' as console;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/core/config/app_config.dart';
import 'package:megaverse/core/routing/route_names.dart';
import 'package:megaverse/pages/web_view.dart';
import 'package:megaverse/services/auth/auth_service.dart'; // New import
import 'package:megaverse/widgets/email_phone_toggle_widget.dart';
import 'package:megaverse/widgets/login_widgets.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    console.log("LoginScreen: Building LoginScreen widget");
    final config = ref.watch(appConfigProvider);
    console.log("LoginScreen: After reading appConfigProvider");

    // Create an instance of AuthService
    final authService = AuthService(ref);

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

                      BuildLoginOption(
                        label: "MetaMask",
                        assetUrl: config.metamaskLoginIconUrl,
                        onPressed: () {
                          // TODO: Implement MetaMask login
                        },
                      ),
                      BuildLoginOption(
                        label: "Trust Wallet",
                        assetUrl: config.trustWalletLoginIconUrl,
                        onPressed: () {
                          // TODO: Implement Trust Wallet login
                        },
                      ),
                      BuildLoginOption(
                        label: "Argent",
                        assetUrl: config.argentLoginIconUrl,
                        onPressed: () {
                          // TODO: Implement Argent login
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialLoginIconButton(
                            assetUrl: config.googleLoginIconUrl,
                            onPressed: () async {
                              await authService.loginWithGoogle();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteNames.home,
                                );
                              }
                            },
                          ),
                          const SizedBox(width: 4),
                          SocialLoginIconButton(
                            assetUrl: config.appleLoginIconUrl,
                            onPressed: () async {
                              await authService.loginWithApple();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteNames.home,
                                );
                              }
                            },
                            iconColor: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SocialLoginIconButton(
                            assetUrl: config.facebookLoginIconUrl,
                            onPressed: () async {
                              await authService.loginWithFacebook();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteNames.home,
                                );
                              }
                            },
                          ),
                          const SizedBox(width: 4),
                          SocialLoginIconButton(
                            assetUrl: config.twitterLoginIconUrl,
                            onPressed: () async {
                              await authService.loginWithTwitter();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RouteNames.home,
                                );
                              }
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: Colors.white30),
                      const SizedBox(height: 16),

                      EmailPhoneInputSwitcher(
                        onSubmit: (value) async {
                          await authService.loginWithEmailPasswordless(value);
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.home,
                            );
                          }
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

  void _openWebView(BuildContext context, String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(title: title, url: url),
      ),
    );
  }
}
