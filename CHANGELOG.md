# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2025-08-14

### Improvements
- Upgraded dependencies cristalyse, google_fonts

## [0.3.0] - 2025-08-13

### Improvements
- Upgraded dependencies

## [0.2.3] - 2025-08-13

### Added
- **HuxDatePicker**: New date selection widget with theme-aware styling and overlay-based calendar
  - Optional `overlayColor` parameter for fine-tuned overlay appearance
- **Public Exports**: Added `HuxDatePicker` and `HuxTimePicker` to `lib/hux.dart`

### Fixed
- **Date Picker Overlay**: Corrected overlay positioning for reliable alignment with the trigger

### Enhanced
- **Documentation & README**: Updated docs pages and README with new details and visuals
- **Example App**: Cleanups and demos for new pickers; added Vercel Analytics to web index

### Assets & Internal
- **Screenshots**: Added component screenshots under `doc/images/` for documentation
- **Coverage**: Committed `coverage/lcov.info` for internal reporting

### Breaking Changes
- None

## [0.2.2] - 2025-07-07

### Added
- **Comprehensive Documentation Site**: Launched complete documentation at [docs.thehuxdesign.com](https://docs.thehuxdesign.com)
  - **Mintlify-powered**: Professional documentation platform with modern design
  - **18 Documentation Pages**: Complete coverage including installation, quickstart, components, and examples
  - **Complete Component Reference**: Detailed API documentation starting with comprehensive HuxButton guide
  - **Real-world Examples**: 25+ working code examples from actual usage patterns
  - **Interactive Navigation**: Organized tabs for Documentation and Examples with intuitive grouping
  - **Design System Guide**: Comprehensive theming documentation with design tokens and color customization
  - **Installation & Setup**: Step-by-step guides with troubleshooting and platform-specific instructions
  - **Accessibility Documentation**: WCAG AA compliance information and best practices
  - **Cross-platform Coverage**: Documentation for Android, iOS, Web (JS/WASM), Windows, macOS, and Linux

### Enhanced
- **README Documentation**: Added comprehensive documentation links and quick navigation
  - Direct links to installation guide, component reference, theming guide, and examples
  - Professional documentation site integration
- **Developer Experience**: Centralized documentation improves discoverability and ease of use
  - Search functionality for quick navigation
  - Mobile-responsive documentation experience
  - Consistent cross-referencing between components and concepts

### Documentation Structure
- **Getting Started**: Installation, quickstart tutorial, and theming basics
- **Components**: Complete reference for all 13+ Hux UI components
- **Examples**: Real-world usage patterns and implementation guides
- **Advanced**: Deep-dive guides for theming, customization, and accessibility
- **External Integration**: Proper linking to pub.dev package and GitHub repository

## [0.2.1] - 2025-07-02

### Changed
- **Code Quality**: Applied consistent code formatting across all source files
- **Dependencies**: Upgraded cristalyse from ^0.6.1 to ^0.9.2 for latest features and improvements

### Added
- **New Dependencies**: Added flutter_svg and vector graphics suite as transitive dependencies
- **Enhanced Compatibility**: Improved package ecosystem integration with latest dependency versions

### Developer Experience
- **Consistent Formatting**: All source files now follow standardized Dart formatting rules
- **Updated Dependencies**: Latest cristalyse version provides improved functionality and stability

## [0.2.0] - 2025-07-02

### Added
- **HuxBadge**: Status indicators and notification counters with semantic variants
  - Six variants: Primary, Secondary, Outline, Success, Destructive, Number badge
  - Consistent design tokens with theme-adaptive colors
  - Small size optimized for UI indicators
- **HuxCheckbox**: Interactive checkbox component with custom styling
  - Smooth state transitions with proper accessibility
  - Optional label support with consistent spacing
  - Theme-aware colors using semantic design tokens
  - Disabled state support
- **HuxSwitch**: Toggle switch component with smooth animations
  - 200ms animated transitions between states
  - Theme-aware styling with primary color integration
  - Consistent border styling using design tokens
- **HuxAlert**: Message boxes with semantic variants and dismissible functionality
  - Three variants: info, success, destructive (error)
  - Theme-adaptive surface and text colors for optimal visibility
  - Optional icons using Feather Icons for consistency
  - Dismissible with close button and callback support
  - Max-width constraint (600px) with center alignment
- **HuxAvatar**: Advanced circular user image component
  - Network image support with graceful error handling
  - Automatic initials generation from names
  - **Gradient Variants**: Five beautiful gradient options (bluePurple, greenBlue, orangeRed, purplePink, tealCyan)
  - Theme-aware background using surfaceSecondary and borderSecondary tokens
  - Multiple size variants (small, medium, large, extraLarge)
- **HuxAvatarGroup**: Display multiple avatars with overlapping or spaced layouts
  - Overlapping layout with 30% offset for space efficiency
  - Smart overflow handling with "+N" count indicator
  - Customizable spacing and maximum visible count
  - Seamless integration with all HuxAvatar variants

### Enhanced
- **Design System Improvements**: Theme-adaptive success and destructive colors
  - **Light Mode Optimization**: Improved visibility with proper contrast ratios
  - Success: Dark green text on light green background (15% opacity)
  - Destructive: Dark red text on light red background (15% opacity)
  - **Dark Mode**: Maintained existing high-contrast appearance
- **Icon System Migration**: Complete transition from Material Design to Feather Icons
  - Consistent iconography across all components and navigation
  - Updated theme toggle, dropdown, and navigation icons
  - Enhanced context menu icons for better visual coherence
- **Navigation & Organization**: Reordered sidebar to match content section sequence
  - Logical component flow: Buttons → Inputs → Cards → Charts → Context Menu → Form Controls → Feedback → Display → Loading
  - Renamed "Display" to "Avatar" for clarity
  - Updated component titles to match actual functionality

### Changed
- **Component Simplification**: Removed size variations for optimal UX
  - HuxCheckbox: Single medium size (removed small/large variants)
  - HuxSwitch: Single medium size (streamlined interface)
  - HuxBadge: Single small size (optimized for indicators)
- **Badge Reorganization**: Improved semantic variant ordering
  - Reordered: Primary, Secondary, Outline, Success, Destructive, Number
  - Removed warning variant for cleaner design language
  - Enhanced outline variant with proper transparent background
- **Component Interactions**: Removed splash effects for cleaner interactions
  - HuxCheckbox and HuxSwitch: Replaced Material splash with GestureDetector
  - Cleaner, more professional interaction feedback

### Fixed
- **Linting & Code Quality**: Resolved all static analysis issues
  - Removed unnecessary .toList() calls in spread operations
  - Fixed BuildContext usage across async gaps with mounted checks
  - Achieved 0 analyzer issues for publication readiness
- **Import Dependencies**: Proper Feather Icons integration
  - Added flutter_feather_icons dependency to all relevant files
  - Consistent icon usage across example and library code

### Developer Experience
- **Enhanced Documentation**: Updated README with comprehensive examples
  - Added usage examples for all new components
  - Fixed import paths (hux_ui → hux)
  - Visual component showcase with proper API documentation
- **Publication Ready**: Complete package preparation
  - All tests passing with comprehensive coverage
  - Static analysis clean with 0 issues
  - Proper semantic versioning for major feature release
- **Improved Example App**: Comprehensive component demonstrations
  - Centered sections with consistent spacing
  - Simplified component showcases focusing on core functionality
  - Theme-aware component examples

### Breaking Changes
- None - Full backward compatibility maintained

## [0.1.5] - 2025-07-01

### Added
- **Light/Dark Mode Toggle**: Complete theme switching functionality in example app with toggle button in sidebar
- **Design Token Architecture**: Comprehensive `HuxTokens` system with semantic color tokens that adapt to light/dark themes
- **WCAG AA Contrast System**: Automatic contrast calculation for button text colors ensuring 4.5:1+ contrast ratio compliance
- **Theme Customization**: Added "Default" theme option and custom color presets (Green #2E7252, Indigo #665CFF, Pink)
- **Comprehensive Documentation**: Added dartdoc comments to all public methods in `HuxTokens` class

### Fixed
- **Button Visibility**: Fixed secondary, outline, and ghost buttons being invisible in light mode
- **Component Theming**: All components now properly adapt to light/dark themes using semantic tokens
- **Color Hardcoding**: Eliminated all hardcoded colors across the entire component library
- **Deprecation Warnings**: Fixed deprecated `Color.red/green/blue` properties → `Color.r/g/b`
- **Context Menu UX**: Restored proper browser context menu prevention for clean web experience

### Changed
- **Complete Component Overhaul**: Refactored ALL components to use `HuxTokens` instead of manual theme checks
  - `HuxButton`: 100% token usage, WCAG AA compliance, theme-aware primary colors
  - `HuxTextField`: Complete token integration, proper semantic color usage
  - `HuxCard`: Updated to use `surfaceElevated`, `borderPrimary`, `textPrimary/tertiary` tokens
  - `HuxLoading`: Theme-aware loading indicators using `primary(context)`
  - `HuxChart`: Theme-aware tokens for grid, axis, and text colors
  - `HuxContextMenu`: Enhanced with proper token usage and divider theming
- **Design System Architecture**: Separation of primitive colors (`HuxColors`) from semantic tokens (`HuxTokens`)
- **Button Enhancements**: 
  - Removed hover shadows and splash effects for cleaner interactions
  - Added custom overlay colors for subtle hover states
  - Dynamic primary color adaptation (black in light mode, white in dark mode)
- **Example App**: Enhanced with comprehensive theme controls and component demonstrations

### Developer Experience
- **Semantic Design Tokens**: Industry-standard design system with meaningful color names
- **Theme Consistency**: All components follow the same theming patterns
- **Better Documentation**: Enhanced API documentation and usage examples
- **Accessibility**: Built-in WCAG AA contrast compliance for all text/background combinations

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

## [0.1.3] - 2025-06-29

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

## [0.1.2] - 2025-06-29

### Fixed
- Applied Dart formatter to all source files for pub.dev static analysis compliance
- Resolved formatting issues to achieve perfect static analysis score

## [0.1.1] - 2025-06-29

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

## [0.1.0] - 2025-06-29

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