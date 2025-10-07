import 'package:flutter/material.dart';

/// Represents a command that can be executed in the HuxCommand component
class HuxCommandItem {
  /// Creates a HuxCommandItem
  const HuxCommandItem({
    required this.id,
    required this.label,
    required this.onExecute,
    this.description,
    this.shortcut,
    this.icon,
    this.category,
  });

  /// Unique identifier for the command
  final String id;

  /// Display name of the command
  final String label;

  /// Description of what the command does
  final String? description;

  /// Keyboard shortcut for the command (e.g., 'Cmd+K')
  final String? shortcut;

  /// Icon to display next to the command
  final IconData? icon;

  /// Category to group commands
  final String? category;

  /// Callback executed when the command is selected
  final VoidCallback onExecute;
}
