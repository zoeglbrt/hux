# Hux UI

A modern Flutter UI package with beautiful, customizable components designed for clean and consistent user interfaces.

[![pub package](https://img.shields.io/pub/v/hux?color=C0C0C0)](https://pub.dev/packages/hux)
[![pub points](https://img.shields.io/pub/points/hux?color=3C3C3C)](https://pub.dev/packages/hux/score)
[![likes](https://img.shields.io/pub/likes/hux?color=C0C0C0)](https://pub.dev/packages/hux/score)
[![Platform](https://img.shields.io/badge/platform-android%20%7C%20ios%20%7C%20web%20%7C%20windows%20%7C%20macos%20%7C%20linux-C0C0C0)](https://flutter.dev/)
[![Flutter support](https://img.shields.io/badge/Flutter-3.16%2B-3C3C3C)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-C0C0C0)](https://opensource.org/licenses/MIT)
[![GitHub Sponsors](https://img.shields.io/badge/GitHub%20Sponsors-Support%20Hux%20UI-red?style=for-the-badge&logo=github)](https://github.com/sponsors/zoeglbrt)

## Features

- 🎨 **Modern Design** - Clean, minimal design language
- 🌙 **Dark Mode Support** - Built-in light and dark theme support
- 📊 **Data Visualization** - Beautiful animated charts for data presentation
- 📱 **Responsive** - Components adapt to different screen sizes
- 🎯 **Customizable** - Extensive customization options
- 🚀 **Easy to Use** - Simple, intuitive API

## Components

### Buttons
- `HuxButton` - Customizable button with multiple variants (primary, secondary, outline, ghost)
- Multiple sizes (small, medium, large)
- Loading states and icon support

![HuxButton Variants](screenshots/hux-buttons.png)

### Cards
- `HuxCard` - Flexible card component with optional header, title, and actions
- Customizable padding, margin, and border radius
- Tap handling support

![HuxCard Examples](screenshots/hux-cards.png)

### Inputs
- `HuxInput` - Enhanced text input with consistent styling (renamed from HuxTextField)
- `HuxDateInput` - Date input with automatic formatting and integrated calendar picker

![HuxInput Component](screenshots/hux-input.png)

- `HuxCheckbox` - Interactive checkbox with custom styling and labels  
- Label, helper text, and error state support
- Multiple sizes and validation

![HuxCheckbox Component](screenshots/hux-checkbox.png)

### Date & Time Pickers
- `showHuxDatePickerDialog` - Modern date picker with month/year selection
- `showHuxTimePickerDialog` - Clean time picker with hour/minute dropdowns
- Theme-aware styling with Hux design tokens
- Responsive calendar grid and smart navigation

### Widgets
- `HuxLoading` - Customizable loading indicators
- `HuxLoadingOverlay` - Full-screen loading overlay

![HuxLoading Indicators](screenshots/hux-loading.png)

- `HuxChart` - Beautiful data visualization with line and bar charts

![HuxChart Visualization](screenshots/hux-charts.png)

### Context Menu
- `HuxContextMenu` - Right-click context menus with smart positioning
- `HuxContextMenuItem` - Individual menu items with icons and states  
- `HuxContextMenuDivider` - Visual separators for menu groups
- Cross-platform support with proper web context menu handling

![HuxContextMenu Component](screenshots/hux-context-menu.png)

*Right-click the example app components to see context menus in action!*

### Switch
- `HuxSwitch` - Toggle switch with smooth animations between on/off states

![HuxSwitch Component](screenshots/hux-switch.png)

### Tooltip
- `HuxTooltip` - Contextual help and information with optional icon support
- Automatic light/dark theme adaptation
- Customizable positioning, colors, and timing
- Support for any icon library (Material Icons, Lucide, Feather, etc.)

![HuxTooltip Component](screenshots/hux-tooltip.png)

### Feedback & Status
- `HuxBadge` - Status indicators and notification counters with semantic variants

![HuxBadge Component](screenshots/hux-badge.png)

- `HuxSnackbar` - Temporary notification messages with semantic variants (previously HuxAlert)

![HuxAlert Component](screenshots/hux-alerts.png)

### Avatar
- `HuxAvatar` - Circular user images with initials fallback, custom colors, and beautiful gradient variants
- `HuxAvatarGroup` - Display multiple avatars with overlapping or spaced layouts

![HuxAvatar Component](screenshots/hux-avatar.png)

### Theme
- `HuxTheme` - Pre-configured light and dark themes
- `HuxColors` - Comprehensive color palette

## Documentation

📚 **[Complete Documentation](https://docs.thehuxdesign.com)** - Visit our comprehensive documentation site for detailed guides, API references, and examples.

**✨ Recently Updated**: Our documentation has been completely restructured with individual pages for each component, alphabetical navigation, and improved clarity!

### Quick Links
- [Installation Guide](https://docs.thehuxdesign.com/installation)
- [Getting Started](https://docs.thehuxdesign.com/quickstart)
- [Component Reference](https://docs.thehuxdesign.com/components/buttons)
- [Theming Guide](https://docs.thehuxdesign.com/theming)
- [Examples](https://docs.thehuxdesign.com/examples/basic-usage)

## Installation

```bash
flutter pub add hux
```


## Usage

### Basic Setup

Wrap your app with the Hux theme:

```dart
import 'package:flutter/material.dart';
import 'package:hux/hux.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hux UI Demo',
      theme: HuxTheme.lightTheme,
      darkTheme: HuxTheme.darkTheme,
      home: MyHomePage(),
    );
  }
}
```

### Using Components

#### Button

```dart
HuxButton(
  onPressed: () => print('Button pressed'),
  child: Text('Primary Button'),
  variant: HuxButtonVariant.primary,
  size: HuxButtonSize.medium,
  icon: Icons.star,
)
```

#### Text Field

```dart
HuxInput(
  label: 'Email',
  hint: 'Enter your email',
  prefixIcon: Icon(Icons.email),
  onChanged: (value) => print(value),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  },
)
```

#### Card

```dart
HuxCard(
  title: 'Card Title',
  subtitle: 'Card subtitle',
  action: IconButton(
    icon: Icon(Icons.more_vert),
    onPressed: () {},
  ),
  child: Text('Card content goes here'),
  onTap: () => print('Card tapped'),
)
```

#### Date & Time Pickers

```dart
// Date picker
final DateTime? selectedDate = await showHuxDatePickerDialog(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
);

// Time picker
final TimeOfDay? selectedTime = await showHuxTimePickerDialog(
  context: context,
  initialTime: TimeOfDay.now(),
);
```

#### Loading

```dart
// Simple loading indicator
HuxLoading(size: HuxLoadingSize.medium)

// Loading overlay
HuxLoadingOverlay(
  isLoading: true,
  message: 'Loading...',
  child: YourContent(),
)
```

#### Charts

```dart
// Line chart
HuxChart.line(
  data: [
    {'x': 1, 'y': 10},
    {'x': 2, 'y': 20},
    {'x': 3, 'y': 15},
  ],
  xField: 'x',
  yField: 'y',
  title: 'Sales Over Time',
  subtitle: 'Monthly data',
  primaryColor: Colors.blue,
)

// Bar chart
HuxChart.bar(
  data: [
    {'category': 'A', 'value': 30},
    {'category': 'B', 'value': 45},
    {'category': 'C', 'value': 25},
  ],
  xField: 'category',
  yField: 'value',
  title: 'Category Analysis',
)
```

#### Context Menu

```dart
HuxContextMenu(
  menuItems: [
    HuxContextMenuItem(
      text: 'Copy',
      icon: FeatherIcons.copy,
      onTap: () => print('Copy action'),
    ),
    HuxContextMenuItem(
      text: 'Paste',
      icon: FeatherIcons.clipboard,
      onTap: () => print('Paste action'),
      isDisabled: true,
    ),
    const HuxContextMenuDivider(),
    HuxContextMenuItem(
      text: 'Delete',
      icon: FeatherIcons.trash2,
      onTap: () => print('Delete action'),
      isDestructive: true,
    ),
  ],
  child: Container(
    padding: const EdgeInsets.all(20),
    child: const Text('Right-click me!'),
  ),
)
```



#### Avatar & Avatar Group

```dart
// Simple avatar with initials
HuxAvatar(
  name: 'John Doe',
  size: HuxAvatarSize.medium,
)

// Gradient avatar
HuxAvatar(
  useGradient: true,
  gradientVariant: HuxAvatarGradient.bluePurple,
  size: HuxAvatarSize.medium,
)

// Avatar group with overlap
HuxAvatarGroup(
  avatars: [
    HuxAvatar(name: 'Alice'),
    HuxAvatar(name: 'Bob'),
    HuxAvatar(useGradient: true, gradientVariant: HuxAvatarGradient.greenBlue),
  ],
  overlap: true,
  maxVisible: 3,
)
```

#### Tooltip

```dart
// Basic tooltip
HuxTooltip(
  message: 'This is a helpful tooltip',
  child: Icon(Icons.info),
)

// Tooltip with icon and custom positioning
HuxTooltip(
  message: 'Information about this feature',
  icon: Icons.info_outline,
  preferBelow: false,
  verticalOffset: 16.0,
  child: HuxButton(
    onPressed: () {},
    variant: HuxButtonVariant.outline,
    child: Text('Hover me'),
  ),
)
```

#### Badges & Alerts

```dart
// Badge variants
HuxBadge(
  label: 'New',
  variant: HuxBadgeVariant.primary,
  size: HuxBadgeSize.small,
)

// Alert with dismissal
HuxAlert(
  variant: HuxAlertVariant.success,
  title: 'Success!',
  message: 'Operation completed successfully.',
  showIcon: true,
  onDismiss: () => print('Alert dismissed'),
)
```

## Customization

All components can be customized using the provided parameters. For more advanced customization, you can extend the theme or override specific component styles.

### Custom Colors

```dart
// Access predefined colors
Container(
  color: HuxColors.primary,
  child: Text('Primary colored container'),
)
```

## Support

If you find Hux UI helpful and would like to support its continued development, consider becoming a GitHub Sponsor! 🌟

[![GitHub Sponsors](https://img.shields.io/badge/GitHub%20Sponsors-Support%20Hux%20UI-red?style=for-the-badge&logo=github)](https://github.com/sponsors/zoeglbrt)

Your support helps us:
- 🚀 Maintain and improve Hux UI components
- 📚 Create better documentation and examples
- 🐛 Fix bugs and add new features faster
- 💡 Invest in new component development

**Thank you to all our sponsors!** Your contributions make a real difference in the Flutter community.

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
