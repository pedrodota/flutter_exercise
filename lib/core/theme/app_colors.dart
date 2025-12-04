import 'package:flutter/material.dart';

// Base colors
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
const transparent = Color(0x00000000);
const appBackground = Color(0xFFE8E8E3); // Background padrão do app (Master Color A)

// Master colors (from Figma)
const masterColorA = appBackground; // Background principal
const masterColorB = Color(0xFF9A73F5); // Accent/borda ativa (roxo)

// Card colors
const cardBackground = Color(0xFFF1F1EF); // Card Background
const cardBorder = Color(0xFFF1EAFB); // Card border base

// Text colors
const darkColor = Color(0xFF0E0F10); // Texto principal
const lightColor = Color(0xFFFAFAFA); // Texto em botões escuros
const taglineColor = Color(0xFF808080); // Texto secundário/subtítulo

// Footer
const footerBackground = Color(0xFFFFFFFF);
const footerSubtitleColor = Color(0x80000000); // rgba(0,0,0,0.5)

// Glow/Shadow colors - #7E52F4 base
const glowColorLight = Color(0x807E52F4); // #7E52F480 - rgba(126, 82, 244, 0.5)
const glowColorMedium = Color(0x4D7E52F4); // #7E52F44D - rgba(126, 82, 244, 0.3)

// Dark theme colors
const darkBackground = Color(0xFF121212);
const darkSurface = Color(0xFF1E1E1E);
const darkCardBackground = Color(0xFF2A2A2A);
const darkTextPrimary = Color(0xFFF5F5F5);
const darkTextSecondary = Color(0xFFB0B0B0);
const darkFooterBackground = Color(0xFF2A2A2A);

/// Extension para acessar cores dinâmicas baseadas no tema atual
extension AppColorsExtension on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;
  bool get isDark => _isDark;

  // Background
  Color get backgroundColor => _isDark ? darkBackground : masterColorA;

  // Card
  Color get cardColor => _isDark ? darkCardBackground : cardBackground;

  // Text
  Color get textPrimaryColor => _isDark ? darkTextPrimary : darkColor;
  Color get textSecondaryColor => _isDark ? darkTextSecondary : taglineColor;
  Color get textOnButtonColor => lightColor; // Sempre claro em botões escuros

  // Footer
  Color get footerColor => _isDark ? darkFooterBackground : footerBackground;
  Color get footerSubtitle => _isDark ? darkTextSecondary : footerSubtitleColor;

  // Button
  Color get buttonColor => _isDark ? masterColorB : darkColor;
}
