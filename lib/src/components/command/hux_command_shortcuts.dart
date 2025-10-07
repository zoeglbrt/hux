import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hux_command_item.dart';
import 'hux_command.dart';

/// A utility class for handling keyboard shortcuts for the command palette
class HuxCommandShortcuts {
  HuxCommandShortcuts._();

  /// Sets up a keyboard listener for CMD+K (or Ctrl+K) to open the command palette
  ///
  /// This should be used in your main app widget to enable global command palette access
  ///
  /// Example:
  /// ```dart
  /// class MyApp extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return KeyboardListener(
  ///       focusNode: FocusNode(),
  ///       onKeyEvent: HuxCommandShortcuts.handleKeyEvent(
  ///         context: context,
  ///         commands: myCommands,
  ///       ),
  ///       child: MaterialApp(
  ///         home: MyHomePage(),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  static void Function(KeyEvent) handleKeyEvent({
    required BuildContext context,
    required List<HuxCommandItem> commands,
    String placeholder = 'Type a command or search...',
    String emptyText = 'No commands found',
    ValueChanged<HuxCommandItem>? onCommandSelected,
    VoidCallback? onClose,
  }) {
    return (KeyEvent event) {
      if (event is KeyDownEvent) {
        final isMac = Theme.of(context).platform == TargetPlatform.macOS ||
            Theme.of(context).platform == TargetPlatform.iOS;

        // Check for CMD+K on Mac or Ctrl+K on other platforms
        final isCommandK = isMac
            ? event.logicalKey == LogicalKeyboardKey.keyK &&
                HardwareKeyboard.instance.isMetaPressed
            : event.logicalKey == LogicalKeyboardKey.keyK &&
                HardwareKeyboard.instance.isControlPressed;

        if (isCommandK) {
          showHuxCommand(
            context: context,
            commands: commands,
            placeholder: placeholder,
            emptyText: emptyText,
            onCommandSelected: onCommandSelected,
            onClose: onClose,
          );
        }
      }
    };
  }

  /// A simple widget that wraps your app and provides command palette shortcuts
  ///
  /// Example:
  /// ```dart
  /// HuxCommandShortcutWrapper(
  ///   commands: myCommands,
  ///   child: MaterialApp(
  ///     home: MyHomePage(),
  ///   ),
  /// )
  /// ```
  static Widget wrapper({
    required List<HuxCommandItem> commands,
    required Widget child,
    String placeholder = 'Type a command or search...',
    String emptyText = 'No commands found',
    ValueChanged<HuxCommandItem>? onCommandSelected,
    VoidCallback? onClose,
  }) {
    return Builder(
      builder: (context) => KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: handleKeyEvent(
          context: context,
          commands: commands,
          placeholder: placeholder,
          emptyText: emptyText,
          onCommandSelected: onCommandSelected,
          onClose: onClose,
        ),
        child: child,
      ),
    );
  }
}
