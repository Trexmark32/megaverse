import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/providers/auth_notifier.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

final logoutVisibleProvider = StateProvider<bool>((ref) => false);
