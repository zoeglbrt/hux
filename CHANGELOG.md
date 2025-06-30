# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.4] - 2025-06-30

### Added
- **Context Menu System**: Complete right-click context menu implementation
  - `HuxContextMenu` - Main wrapper widget with smart positioning and cross-platform support
  - `HuxContextMenuItem` - Individual menu items with icons, disabled states, and destructive actions
  - `HuxContextMenuDivider` - Visual separators for organizing menu groups
- **Web Platform Optimization**: Proper browser context menu prevention using `universal_html`
- **Cross-Platform Support**: Seamless context menu experience across desktop, mobile, and web
- **Smart Positioning**: Automatic menu positioning to prevent screen overflow
- **Consistent Design**: Context menus follow the established Hux UI design system

### Changed
- **Enhanced Example App**: Added comprehensive context menu demonstrations
- **Updated Documentation**: Added context menu usage examples and API documentation
- **Navigation Enhancement**: Added context menu section to the example app sidebar

### Dependencies
- Added `universal_html: ^2.2.4` for web-specific context menu handling

### Developer Experience
- Right-click interactions now work seamlessly across all platforms
- Browser's default context menu is properly disabled on web
- Easy-to-use API following established Hux UI patterns
- Comprehensive examples showing various context menu configurations

## [0.1.3] - 2025-01-07

### Added
- **Component Screenshots**: Added beautiful visual documentation for all UI components
  - HuxButton variants showcase
  - HuxCard configuration examples
  - HuxTextField input demonstrations
  - HuxLoading indicator samples
  - HuxChart data visualization examples
- **Enhanced Package Metadata**: Comprehensive topics for better pub.dev discoverability
- **Documentation Links**: Added issue tracker and documentation URLs for better user support

### Changed
- **Package Description**: Updated to "an open-source state of the art UI library for Flutter 💙"
- **README Enhancement**: Integrated component screenshots for visual documentation
- **Pub.dev Presentation**: Improved package discovery with targeted topics and metadata

### Developer Experience
- Better package discoverability on pub.dev through comprehensive topics
- Visual documentation helps developers understand components at a glance
- Enhanced metadata provides clear paths for support and documentation

## [0.1.2] - 2025-01-07

### Fixed
- Applied Dart formatter to all source files for pub.dev static analysis compliance
- Resolved formatting issues to achieve perfect static analysis score

## [0.1.1] - 2025-01-07

### Fixed
- Fixed `CardTheme` deprecation by migrating to `CardThemeData` for better Flutter compatibility
- Updated Flutter constraint to `>=3.16.0` to ensure compatibility with modern Flutter APIs

### Added
- **Comprehensive API Documentation**: Added dartdoc comments to all public API members (20%+ coverage for pub.dev requirements)
- **WebAssembly (WASM) Support**: Added explicit platform support for WASM compilation targets
- **Enhanced Code Quality**: Added strict linting rules with `analysis_options.yaml`
- **Platform Declaration**: Explicit support for Android, iOS, Linux, macOS, Web (JS/WASM), and Windows

### Changed
- Tightened dependency constraints for better compatibility (`google_fonts: ^6.2.1`)
- Improved documentation with detailed examples and usage instructions for all components
- Enhanced enum documentation with clear descriptions for all variants

### Developer Experience
- Better pub.dev scoring with improved documentation coverage
- WASM compilation support for high-performance web applications
- Stricter code quality enforcement with comprehensive linting rules
- Improved dependency resolution and compatibility testing

## [0.1.0] - 2025-06-28

### Added
- Initial release of Hux UI package
- `HuxButton` component with multiple variants and sizes
- `HuxCard` component with header and action support
- `HuxTextField` component with validation and sizing options
- `HuxLoading` component with size variants
- `HuxLoadingOverlay` for full-screen loading states
- `HuxChart` component for data visualization with line and bar chart support
- `HuxTheme` with light and dark theme configurations
- `HuxColors` comprehensive color palette
- Support for Material 3 design system
- Dark mode support for all components
- Comprehensive documentation and examples

### Features
- Modern, clean design language
- Consistent component API
- Beautiful data visualization with animated charts
- Customizable styling options
- Responsive design support
- Accessibility considerations 