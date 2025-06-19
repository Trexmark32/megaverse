import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:megaverse/providers/ui_provider.dart';

class EmailPhoneInputSwitcher extends ConsumerWidget {
  final void Function(String) onSubmit;
  const EmailPhoneInputSwitcher({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showInput = ref.watch(showEmailInputProvider);
    final inputError = ref.watch(inputErrorProvider);
    final controller = ref.watch(inputControllerProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showInput
          ? Column(
              key: const ValueKey('input'),
              children: [
                TextField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter email or phone',
                    errorText: inputError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        ref.read(showEmailInputProvider.notifier).state = false;
                        controller.clear();
                        ref.read(inputErrorProvider.notifier).state = null;
                      },
                    ),
                  ),
                  onSubmitted: (value) {
                    final trimmed = value.trim();

                    // Simple validation
                    final emailRegex = RegExp(
                      r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                    );
                    final phoneRegex = RegExp(r"^\+?[0-9]{7,15}$");

                    if (trimmed.isEmpty) {
                      ref.read(inputErrorProvider.notifier).state =
                          'This field is required';
                    } else if (!emailRegex.hasMatch(trimmed) &&
                        !phoneRegex.hasMatch(trimmed)) {
                      ref.read(inputErrorProvider.notifier).state =
                          'Enter a valid email or phone';
                    } else {
                      ref.read(inputErrorProvider.notifier).state = null;
                      onSubmit(trimmed);
                    }
                  },
                ),
              ],
            )
          : ElevatedButton(
              key: const ValueKey('button'),
              onPressed: () {
                ref.read(showEmailInputProvider.notifier).state = true;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Continue with Email/Phone"),
            ),
    );
  }
}
