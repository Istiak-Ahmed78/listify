enum KThemeMode {
  LIGHT,
  DARK,
}

abstract class KTheme {
  static var kThemeMode = KThemeMode.LIGHT;

  static bool darkMode() => kThemeMode == KThemeMode.DARK;
}
