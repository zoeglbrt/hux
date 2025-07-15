import 'package:flutter/material.dart';
import 'package:hux/src/theme/hux_tokens.dart';

/// Displays a Hux UI-themed date picker dialog.
///
/// This function wraps the standard `showDatePicker` and applies a custom
/// theme using `HuxTokens` to ensure it matches the application's design system.

Future<DateTime?> showHuxDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          // Apply HuxTokens to the color scheme for the picker
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: HuxTokens.primary(context),
                onPrimary: HuxTokens.textInvert(context),
                surface: HuxTokens.surfaceElevated(context),
                onSurface: HuxTokens.textPrimary(context),
              ),
          // Style dialog shape and buttons
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: HuxTokens.primary(context),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}

/// Displays a Hux UI-themed time picker dialog.
///
/// This function wraps the standard `showTimePicker` and applies a custom
/// theme using `HuxTokens` to ensure it matches the application's design system.
Future<TimeOfDay?> showHuxTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          // Apply HuxTokens to the color scheme for the picker
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: HuxTokens.primary(context),
                onPrimary: HuxTokens.textInvert(context),
                surface: HuxTokens.surfaceElevated(context),
                onSurface: HuxTokens.textPrimary(context),
              ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: HuxTokens.primary(context),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: HuxTokens.surfaceElevated(context),
          ),
        ),
        child: child!,
      );
    },
  );
}
