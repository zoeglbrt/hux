# Contributing to Hux UI

Thanks for wanting to contribute to Hux UI! Whether you're fixing bugs, adding features, or improving docs, we appreciate your help in making Flutter development a bit more delightful.

## Quick Start

1. **Fork the repo** on [GitHub](https://github.com/lofidesigner/hux)
2. **Clone your fork**: `git clone https://github.com/YOUR_USERNAME/hux.git`
3. **Install dependencies**: `flutter pub get`
4. **Run the example**: `cd example && flutter run`
5. **Make your changes** and test them
6. **Submit a PR**

## Development Setup

### Requirements

- **Flutter**: 3.16.0+ 
- **Dart**: 3.0.0+
- **Git**: Any recent version

### Getting Started

```bash
# Clone the repo
git clone https://github.com/lofidesigner/hux.git
cd hux

# Install dependencies
flutter pub get

# Run tests to make sure everything works
flutter test

# Launch the example app
cd example
flutter pub get
flutter run
```

The example app is your playground—it shows off all the components and lets you test changes quickly.

## Project Structure

```
hux/
├── lib/
│   ├── src/
│   │   ├── components/     # UI components (buttons, cards, etc.)
│   │   ├── theme/          # Theme system and design tokens
│   │   └── widgets/        # Complex widgets (charts, context menus)
│   └── hux.dart           # Main export file
├── example/               # Demo app
├── doc/                   # Documentation source
├── test/                  # Unit tests
└── pubspec.yaml          # Package dependencies
```

## What We're Looking For

### 🕵️ Bug Fixes
Found something broken? We'd love a fix! Please include:
- Steps to reproduce the issue
- Expected vs actual behavior
- Test case if possible

### ✨ New Components
Want to add a new component? Great! Make sure it:
- Follows the existing design patterns
- Includes proper accessibility features (WCAG AA compliance)
- Has comprehensive documentation
- Works across all supported platforms
- Includes tests

### 📚 Documentation
Documentation improvements are always welcome:
- Fix typos or unclear explanations
- Add examples for complex features
- Improve code comments
- Update the docs site content

### 🎨 Design System
Improvements to the theme system, design tokens, or accessibility features are highly valued.

## Code Standards

### Style Guide

We use `flutter_lints` to keep code consistent:

```bash
# Check for linting issues
flutter analyze

# Format code
dart format .
```

### Component Guidelines

When creating components:

1. **Follow the naming convention**: `HuxComponentName`
2. **Use design tokens**: Access colors via `HuxTokens` and `HuxColors`
3. **Include accessibility**: Proper semantics, contrast ratios, keyboard navigation
4. **Support theming**: Components should work in both light and dark themes
5. **Add documentation**: Include dartdoc comments explaining usage

Example component structure:

```dart
/// A beautiful button component with multiple variants.
///
/// Example:
/// ```dart
/// HuxButton(
///   onPressed: () => print('Hello!'),
///   child: Text('Click me'),
///   variant: HuxButtonVariant.primary,
/// )
/// ```
class HuxButton extends StatelessWidget {
  const HuxButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = HuxButtonVariant.primary,
    // ... other params
  });

  // ... implementation
}
```

### Testing

Write tests for your components:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

We aim for good test coverage, especially for:
- Component behavior
- Accessibility features
- Theme switching
- Edge cases

## Accessibility First

Hux UI is built with accessibility in mind. Every component should:

- Have proper contrast ratios (WCAG AA: 4.5:1 minimum)
- Support keyboard navigation
- Include semantic labels and roles
- Work with screen readers
- Handle focus management correctly

We use automated contrast calculation to ensure text readability across all color combinations.

## Submitting Changes

### Commit Messages

Use clear, descriptive commit messages:

```
feat: add HuxToggleButton component
fix: resolve contrast calculation edge case  
docs: update HuxCard usage examples
style: format code according to flutter_lints
```

### Pull Request Process

1. **Create a branch**: `git checkout -b feature/your-feature-name`
2. **Make your changes** with tests
3. **Update documentation** if needed
4. **Run the checklist** below
5. **Submit the PR** with a clear description

### Pre-submission Checklist

- [ ] Code follows style guidelines (`flutter analyze` passes)
- [ ] All tests pass (`flutter test`)
- [ ] New components include tests
- [ ] Documentation is updated
- [ ] Example app demonstrates new features
- [ ] Accessibility requirements are met
- [ ] Components work in both light and dark themes

## Need Help?

- **Issues**: [github.com/lofidesigner/hux/issues](https://github.com/lofidesigner/hux/issues)
- **Discussions**: Use GitHub discussions for questions
- **Documentation**: [docs.thehuxdesign.com](https://docs.thehuxdesign.com)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors are listed in the README and receive our eternal gratitude 🫶
