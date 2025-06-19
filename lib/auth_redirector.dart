import 'dart:developer' as console;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/core/routing/route_names.dart';
import 'package:megaverse/providers/auth_provider.dart';

class AuthRedirector extends ConsumerWidget {
  const AuthRedirector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      final isAuthenticated = ref.read(authProvider);
      console.log("AuthRedirector: Auth state changed to $isAuthenticated");
      console.log("previous: $previous");
      console.log("next: $next");
      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, RouteNames.home);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.login);
      }
    });

    return const SizedBox.shrink();
  }
}
