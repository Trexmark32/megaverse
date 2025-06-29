import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final BorderSide? side;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.side,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor ?? Colors.white,
        backgroundColor: backgroundColor,
        side: side ?? const BorderSide(color: Colors.white70),
        padding: padding,
      ),
      child: Text(
        text,
        style:
            textStyle ??
            TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
