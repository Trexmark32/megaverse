import 'package:flutter/material.dart';

const _glassColor = Color(0xff666666); // Base glass color
const _iconShadowColor = Color(0xff333333); // Icon shadow color

Color getGlassColor(double opacity) {
  return _glassColor.withValues(alpha: opacity);
}

Color getIconShadowColor(double opacity) {
  return _iconShadowColor.withValues(alpha: opacity);
}

final ThemeData lightTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.light,
    primary: Colors.white,
    onPrimary: Colors.black54,
    secondary: const Color.from(alpha: 1, red: 0.376, green: 0.49, blue: 0.545),
    onSecondary: Colors.blueGrey[800]!,
    error: Colors.redAccent,
    onError: Colors.redAccent[200]!, // Change to desired text color
    surface: getGlassColor(0.5), // Glass effect for backgrounds
    onSurface: Colors.grey[700]!,
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xff777777)),
  ),

  iconTheme: const IconThemeData(color: Colors.white),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(),
    textTheme: ButtonTextTheme.primary,
    buttonColor: getGlassColor(0.5),
    height: 48,
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Colors.grey[900]!,
    onPrimary: Colors.white,
    secondary: Colors.blueGrey,
    onSecondary: Colors.blueGrey[800]!,
    error: Colors.redAccent,
    onError: Colors.redAccent[200]!, // Change to desired text color
    surface: getGlassColor(0.6), // Increased opacity for backgrounds
    onSurface: Colors.grey[100]!,
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.white70,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xff444444)),
  ),

  iconTheme: IconThemeData(color: getIconShadowColor(1.0)),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(),
    textTheme: ButtonTextTheme.primary,
    buttonColor: getGlassColor(0.6),
    height: 48,
  ),
);
