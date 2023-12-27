import 'package:flutter/material.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';

class Styles {
  static ThemeData setMaterialTheme3(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: colorSecondary,
        selectionColor: colorSecondary,
        selectionHandleColor: colorSecondary,
      ),
      scaffoldBackgroundColor: colorPrimary,
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: colorSecondary)),
      dropdownMenuTheme: DropdownMenuThemeData(textStyle: dropdownTextStyle),
      iconTheme: const IconThemeData(color: colorPrimary),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: colorPrimary,
        onPrimary: colorOnPrimary,
        secondary: colorSecondary,
        onSecondary: colorOnSecondary,
        error: colorError,
        onError: colorError,
        background: colorPrimary,
        onBackground: colorOnPrimary,
        surface: colorSurface,
        onSurface: colorOnSurface,
      ),
    );
  }
}
