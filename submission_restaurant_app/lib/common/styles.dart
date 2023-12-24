import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final myTextTheme = TextTheme(
  // Display
  displayLarge: GoogleFonts.playfairDisplay(
      fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -1.5),
  displayMedium: GoogleFonts.playfairDisplay(
      fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.playfairDisplay(fontSize: 36, fontWeight: FontWeight.w400),
  // Headline
  headlineLarge: GoogleFonts.inter(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineMedium: GoogleFonts.inter(
      fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w400),
  // Title
  titleLarge: GoogleFonts.inter(
      fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleMedium: GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleSmall: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  // Body
  bodyLarge: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  bodySmall: GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  // Label
  labelLarge: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  labelMedium: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: GoogleFonts.roboto(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  ),
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF914C00),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDCC3),
  onPrimaryContainer: Color(0xFF2F1500),
  secondary: Color(0xFF705D00),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFE173),
  onSecondaryContainer: Color(0xFF221B00),
  tertiary: Color(0xFF984061),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD9E2),
  onTertiaryContainer: Color(0xFF3E001D),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF201A17),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF201A17),
  surfaceVariant: Color(0xFFF3DFD2),
  onSurfaceVariant: Color(0xFF51443B),
  outline: Color(0xFF847469),
  onInverseSurface: Color(0xFFFAEEE8),
  inverseSurface: Color(0xFF352F2B),
  inversePrimary: Color(0xFFFFB77E),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF914C00),
  outlineVariant: Color(0xFFD6C3B7),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFB77E),
  onPrimary: Color(0xFF4D2600),
  primaryContainer: Color(0xFF6E3900),
  onPrimaryContainer: Color(0xFFFFDCC3),
  secondary: Color(0xFFE4C44A),
  onSecondary: Color(0xFF3B2F00),
  secondaryContainer: Color(0xFF554500),
  onSecondaryContainer: Color(0xFFFFE173),
  tertiary: Color(0xFFFFB1C8),
  onTertiary: Color(0xFF5E1132),
  tertiaryContainer: Color(0xFF7B2949),
  onTertiaryContainer: Color(0xFFFFD9E2),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF201A17),
  onBackground: Color(0xFFECE0DA),
  surface: Color(0xFF201A17),
  onSurface: Color(0xFFECE0DA),
  surfaceVariant: Color(0xFF51443B),
  onSurfaceVariant: Color(0xFFD6C3B7),
  outline: Color(0xFF9E8D82),
  onInverseSurface: Color(0xFF201A17),
  inverseSurface: Color(0xFFECE0DA),
  inversePrimary: Color(0xFF914C00),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFFB77E),
  outlineVariant: Color(0xFF51443B),
  scrim: Color(0xFF000000),
);
