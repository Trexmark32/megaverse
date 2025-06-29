import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginIconButton extends StatelessWidget {
  final String assetUrl;
  final ColorFilter? iconColor;
  final VoidCallback? onPressed;

  const SocialLoginIconButton({
    super.key,
    required this.assetUrl,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white12),
        minimumSize: const Size(18, 48),
      ),
      child: SvgPicture.network(
        assetUrl,
        height: 26,
        width: 26,
        colorFilter: iconColor,
        placeholderBuilder: (BuildContext context) => const SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class BuildLoginOption extends StatelessWidget {
  final String label;
  final String assetUrl;
  final VoidCallback? onPressed;

  const BuildLoginOption({
    super.key,
    required this.label,
    required this.assetUrl,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white12),
          minimumSize: const Size(double.infinity, 48),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Image.network(
              assetUrl,
              height: 26,
              width: 26,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 26,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
