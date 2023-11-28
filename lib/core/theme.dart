import 'package:flutter/material.dart';

// TODO: Update AppTheme

/// Application custom styles and themes
class AppTheme {
  static const int primaryInt = 0xFF5FCB8A; // Used for primary swatch

  // APP COLOR
  static Color primary = const Color(primaryInt);
  static Color error = const Color(0xFFFF564B);
  static Color black = const Color(0xFF242424);

  // TODO: Change this if required
  static Map<int, Color> primarysMaps = {
    50: primary, // 10%
    100: primary, // 20%
    200: primary, // 30%
    300: primary, // 40%
    400: primary, // 50%
    500: primary, // 60%
    600: primary, // 70%
    700: primary, // 80%
    800: primary, // 90%
    900: primary, // 100%
  };

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: MaterialColor(primaryInt, primarysMaps),
    ),
    fontFamily: 'Roboto',
    primarySwatch: MaterialColor(primaryInt, primarysMaps),
    scaffoldBackgroundColor: Colors.white,
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE9E9E9),
      thickness: 1,
      space: 0,
      indent: 0,
      endIndent: 0,
    ),

    // TODO: Do you have your own text theme?
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 57.0,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 45.0,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 36.0,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 32.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 28.0,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 24.0,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 22.0,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        letterSpacing: 0.1,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
        letterSpacing: 0.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        letterSpacing: 0.4,
      ),
    ).apply(
      fontFamily: 'Roboto',
      bodyColor: black,
      displayColor: black,
      fontSizeFactor: 1,
    ),
  );
}
