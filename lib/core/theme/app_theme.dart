import 'package:flutter/material.dart';

const _glassColor = Color(0xff666666); // Base glass color
const _iconShadowColor = Color.fromARGB(
  255,
  167,
  167,
  167,
); // Icon shadow color

Color getGlassColor(double opacity) {
  return _glassColor.withValues(alpha: opacity);
}

Color getIconShadowColor(double opacity) {
  return _iconShadowColor.withValues(alpha: opacity);
}

final ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.light(
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
      color: Colors.black,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
  ),
  splashFactory: NoSplash.splashFactory,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey[500],
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    enableFeedback: false,
  ),

  iconTheme: const IconThemeData(color: Colors.black),
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
      color: Colors.white,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
  ),

  splashFactory: NoSplash.splashFactory,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey[700],
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    enableFeedback: false,
  ),
  iconTheme: IconThemeData(color: Colors.white),

  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(),
    textTheme: ButtonTextTheme.primary,
    buttonColor: getGlassColor(0.6),
    height: 48,
  ),
);
