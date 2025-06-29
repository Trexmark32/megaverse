import 'package:flutter/material.dart';
import 'package:megaverse/pages/app_splash_screen.dart';
import 'package:megaverse/pages/error_screen.dart';
import 'package:megaverse/pages/home_screen.dart';
import 'package:megaverse/pages/login_screen.dart';
import 'package:megaverse/pages/wallet_screen.dart';
import 'package:megaverse/pages/web_view.dart';
import 'package:megaverse/widgets/email_phone_toggle_widget.dart';

import 'route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.loadingScreen:
      return MaterialPageRoute(builder: (_) => const LoadingScreen());
    case RouteNames.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case RouteNames.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case RouteNames.wallet:
      return MaterialPageRoute(builder: (_) => WalletScreen());
    case RouteNames.emailPhoneInputSwitcher:
      return MaterialPageRoute(
        builder: (_) => EmailPhoneInputSwitcher(onSubmit: (value) {}),
      );
    case RouteNames.webView:
      return MaterialPageRoute(
        builder: (_) => const WebViewPage(title: "", url: ""),
      );
    case RouteNames.error:
      return MaterialPageRoute(
        builder: (_) => ErrorScreen(error: 'Unknown route: ${settings.name}'),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => ErrorScreen(error: 'Page not found: ${settings.name}'),
      );
  }
}
