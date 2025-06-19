import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig(
    appName: "Megaverse",
    appUrl: "appUrl.com",
    // Social Login Icons
    googleLoginIconUrl: dotenv.env['googleLoginIconUrl']!,
    appleLoginIconUrl: dotenv.env['appleLoginIconUrl']!,
    facebookLoginIconUrl: dotenv.env['facebookLoginIconUrl']!,
    twitterLoginIconUrl: dotenv.env['twitterLoginIconUrl']!,
    // Wallet Login Icons
    metamaskLoginIconUrl: dotenv.env['metamaskLoginIconUrl']!,
    trustWalletLoginIconUrl: dotenv.env['trustWalletLoginIconUrl']!,
    argentLoginIconUrl: dotenv.env['argentLoginIconUrl']!,
  );
});

class AppConfig {
  final String appName;
  final String appUrl;
  // Add fields for your image URLs
  final String googleLoginIconUrl;
  final String appleLoginIconUrl;
  final String facebookLoginIconUrl;
  final String twitterLoginIconUrl;
  final String metamaskLoginIconUrl;
  final String trustWalletLoginIconUrl;
  final String argentLoginIconUrl;
  // final String appVersion;
  // final String appDescription;
  // final String appAuthor;
  // final String appAuthorEmail;
  // final String appAuthorUrl;
  // final String appSupportEmail;
  // final String appSupportUrl;
  // final String appPrivacyPolicyUrl;
  // final String appTermsOfServiceUrl;
  // final String appLogoUrl;
  // final String appLogoDarkUrl;
  // final String appLogoLightUrl;
  // final String appLogoSmallUrl;
  // final String appLogoSmallDarkUrl;
  // final String appLogoSmallLightUrl;
  // final String appLogoLargeUrl;
  // final String appLogoLargeDarkUrl;
  // final String appLogoLargeLightUrl;

  AppConfig({
    required this.appName,
    required this.appUrl,
    required this.googleLoginIconUrl,
    required this.appleLoginIconUrl,
    required this.facebookLoginIconUrl,
    required this.twitterLoginIconUrl,
    required this.metamaskLoginIconUrl,
    required this.trustWalletLoginIconUrl,
    required this.argentLoginIconUrl,
    // required this.appVersion,
    // required this.appDescription,
    // required this.appAuthor,
    // required this.appAuthorEmail,
    // required this.appAuthorUrl,
    // required this.appSupportEmail,
    // required this.appSupportUrl,
    // required this.appPrivacyPolicyUrl,
    // required this.appTermsOfServiceUrl,
    // required this.appLogoUrl,
    // required this.appLogoDarkUrl,
    // required this.appLogoLightUrl,
    // required this.appLogoSmallUrl,
    // required this.appLogoSmallDarkUrl,
    // required this.appLogoSmallLightUrl,
    // required this.appLogoLargeUrl,
    // required this.appLogoLargeDarkUrl,
    // required this.appLogoLargeLightUrl,
  });
}
