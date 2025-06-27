import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/core/routing/route_names.dart';
import 'package:megaverse/providers/auth_notifier.dart';
import 'package:megaverse/providers/auth_provider.dart';

class AuthRedirector extends ConsumerStatefulWidget {
  const AuthRedirector({super.key});

  @override
  ConsumerState<AuthRedirector> createState() => _AuthRedirectorState();
}

class _AuthRedirectorState extends ConsumerState<AuthRedirector> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue<AuthState>>(authProvider, (prev, next) {
      if (_isNavigating) return;

      next.whenOrNull(
        data: (state) {
          _isNavigating = true;
          if (state.status == AuthStatus.authenticated) {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.home,
            ).whenComplete(() => _isNavigating = false);
          } else if (state.status == AuthStatus.unauthenticated) {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.login,
            ).whenComplete(() => _isNavigating = false);
          } else {
            _isNavigating = false;
          }
        },
        error: (e, st) => _isNavigating = false,
        loading: () => _isNavigating = false,
      );
    });

    return authState.when(
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      error: (e, st) => Center(child: Text("Error: $e")),
      data: (_) => const SizedBox(),
    );
  }
}
