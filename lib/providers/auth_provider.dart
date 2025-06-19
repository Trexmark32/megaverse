import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateProvider<bool>((ref) => false);

final logoutVisibleProvider = StateProvider<bool>((ref) => false);
