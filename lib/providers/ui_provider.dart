import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final showEmailInputProvider = StateProvider<bool>((ref) => false);

final inputErrorProvider = StateProvider<String?>((ref) => null);

final inputControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(),
);
