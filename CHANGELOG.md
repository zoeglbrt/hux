# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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