import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { initial, authenticated, unauthenticated, loading }

class AuthState {
  final AuthStatus status;
  const AuthState(this.status);
}

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    return const AuthState(AuthStatus.initial);
  }

  void setAuthenticated() {
    state = AsyncData(const AuthState(AuthStatus.authenticated));
  }

  void setUnauthenticated() {
    state = AsyncData(const AuthState(AuthStatus.unauthenticated));
  }

  void setLoading() {
    state = const AsyncLoading();
  }
}
