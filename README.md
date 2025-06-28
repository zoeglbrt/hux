# Hux UI

A modern Flutter UI package with beautiful, customizable components designed for clean and consistent user interfaces.

## Features

- 🎨 **Modern Design** - Clean, minimal design language
- 🌙 **Dark Mode Support** - Built-in light and dark theme support
- 📱 **Responsive** - Components adapt to different screen sizes
- 🎯 **Customizable** - Extensive customization options
- 🚀 **Easy to Use** - Simple, intuitive API

## Components

### Buttons
- `HuxButton` - Customizable button with multiple variants (primary, secondary, outline, ghost)
- Multiple sizes (small, medium, large)
- Loading states and icon support

### Cards
- `HuxCard` - Flexible card component with optional header, title, and actions
- Customizable padding, margin, and border radius
- Tap handling support

### Inputs
- `HuxTextField` - Enhanced text input with consistent styling
- Label, helper text, and error state support
- Multiple sizes and validation

### Widgets
- `HuxLoading` - Customizable loading indicators
- `HuxLoadingOverlay` - Full-screen loading overlay

### Theme
- `HuxTheme` - Pre-configured light and dark themes
- `HuxColors` - Comprehensive color palette

## Installation

Add this package to your `pubspec.yaml` file:

```yaml
dependencies:
  hux_ui: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Setup

Wrap your app with the Hux theme:

```dart
import 'package:flutter/material.dart';
import 'package:hux_ui/hux.dart';

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
HuxTextField(
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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
