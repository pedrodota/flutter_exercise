import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: fontAktivGrotesk,
        scaffoldBackgroundColor: masterColorA,
        colorScheme: const ColorScheme.light(
          primary: masterColorB,
          secondary: masterColorB,
          surface: cardBackground,
          onPrimary: lightColor,
          onSecondary: lightColor,
          onSurface: darkColor,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: fontAktivGrotesk,
            fontWeight: extraBoldWeight,
            color: darkColor,
          ),
          displayMedium: TextStyle(
            fontFamily: fontAktivGrotesk,
            fontWeight: boldWeight,
            color: darkColor,
          ),
          bodyLarge: TextStyle(
            fontFamily: fontAktivGrotesk,
            fontWeight: regularWeight,
            color: darkColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: fontAktivGrotesk,
            fontWeight: regularWeight,
            color: darkColor,
          ),
          labelLarge: TextStyle(
            fontFamily: fontAktivGrotesk,
            fontWeight: mediumWeight,
            color: lightColor,
          ),
          labelMedium: TextStyle(
            fontFamily: fontAktivGrotesk,
            fontWeight: regularWeight,
            color: taglineColor,
          ),
        ),
      );
}
