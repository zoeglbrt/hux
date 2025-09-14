# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.8.4] - 2025-09-14

### Enhanced
- **README Design Overhaul**: Redesign of project badges and visual hierarchy
  - Implemented modern flat badge styling with consistent black/white color scheme
  - Reorganized badge layout with better grouping and visual flow
  - Added new Pub Downloads badge to showcase package usage metrics
  - Integrated Figma community file badge with download count display
  - Removed emojis throughout for a cleaner, more professional aesthetic
  - Enhanced logo sizing with proper HTML img tag for better control

### Changed
- **Visual Design**: Transitioned from colorful badges to minimal black/white design system
- **Badge Organization**: Grouped related badges for better visual hierarchy

## [0.8.3] - 2025-09-09

### Enhanced
- **Documentation Media**: Added comprehensive images to component documentation
  - Added checkbox images (checked, unchecked, disabled, with/without label)
  - Added radio button images (checked, unchecked, disabled states)
  - Added dialog images for all size variants and states
  - Added input images (enabled, focused, disabled, error, helper text states)
  - Added snackbar images for all variants (info, success, error, warning)
  - Added switch images (on, off, disabled, with label states)
  - Added tooltip images for different configurations
  - Enhanced visual documentation for better developer experience

### Fixed
- **Documentation Consistency**: Improved component documentation structure
  - Removed redundant sections across multiple components
  - Fixed alphabetical ordering of components in navigation
  - Updated examples to use Hux components consistently
  - Clarified tooltip icon usage and placement
  - Streamlined states sections to avoid repetition

### Improved
- **Component Documentation**: Enhanced visual examples and code clarity
  - Better image organization and naming
  - Clearer state demonstrations
  - More consistent code examples using Hux design system
  - Improved accessibility and usability information

## [0.8.2] - 2025-09-07

### Enhanced
- **Documentation Screenshots**: Added individual button variant screenshots to Mintlify documentation
  - Added primary, secondary, outline, and ghost button variant images
  - Added small, medium, and large button size images
  - Added icon with text and icon-only button examples
  - Enhanced visual documentation for better developer experience
  - [View updated button documentation](https://docs.thehuxdesign.com/components/buttons)

## [0.8.1] - 2025-08-31

### Fixed
- **Pub.dev Compliance**: Fixed screenshot count for package validation
  - Reduced screenshots in pubspec.yaml from 11 to 10 (pub.dev limit)

## [0.8.0] - 2025-08-31

### Added
- **HuxDialog**: New general-purpose dialog component with modern design
  - Multiple size variants (small, medium, large, extra large)
  - Built-in close button with ghost styling and precise positioning
  - Consistent Hux design system integration using HuxTokens
  - Support for title, subtitle, content, and action buttons
  - Responsive width constraints and proper spacing
  - Comprehensive test coverage and documentation

### Enhanced
- **HuxButton**: Improved icon-only button support
  - Fixed hover effects for icon-only buttons
  - Automatic square dimensions for icon-only buttons

### Fixed
- **Component Consistency**: Enhanced button behavior for better UX
- **Documentation Updates**: Added comprehensive dialog component documentation

## [0.7.0] - 2025-08-26

### Added
- **HuxRadio**: New radio button component for single selection from groups
  - Support for different value types (String, int, bool, enums)
  - Consistent 18x18 pixel sizing for optimal UX
  - Theme-aware styling with automatic light/dark adaptation
  - Support for disabled state and optional labels
  - Comprehensive test coverage and documentation

## [0.6.0] - 2025-08-24

### Added
- **Documentation Restructuring**: Complete reorganization of component documentation
  - Individual pages for each component (Input, Checkbox, Switch, Alert, Badge)
  - Alphabetical navigation ordering for better discoverability
- **Snackbar Documentation**: Renamed Alert to Snackbar for better clarity
  - More descriptive and industry-standard terminology
  - Updated all code examples to use HuxSnackbar naming
  - Maintains backward compatibility with HuxAlert class

### Enhanced
- **Component Organization**: Improved documentation structure
  - Split monolithic "Input Components" into individual pages
  - Split monolithic "Feedback Components" into individual pages
- **Color System**: Refactored color usage for better maintainability
  - Added explicit color constants (red10, red60, grey35, green10, green60)
  - Replaced runtime `.withValues(alpha: X)` with predefined constants
  - Improved performance and code readability
- **Badge Component**: Updated to use destructive design tokens
  - Consistent destructive styling across error and destructive variants
  - Better theme integration and accessibility

### Improved
- **Documentation Navigation**: Professional, organized structure
  - Removed overview pages in favor of direct component access
  - Consistent component naming throughout documentation
  - Better SEO with individual component pages
- **Developer Experience**: Cleaner, more focused documentation
  - Each component gets dedicated, comprehensive documentation
  - Easier to find specific component information
  - Consistent formatting and examples across all components

### Removed
- **Legacy Files**: Cleaned up redundant documentation files
  - Removed `inputs.mdx` overview page
  - Streamlined navigation structure

## [0.5.0] - 2025-08-23

### Added
- **HuxTooltip**: New tooltip component with contextual help and information
  - Optional icon support for enhanced visual communication
  - Automatic light/dark theme adaptation
  - Customizable positioning, colors, and timing
  - Support for any icon library (Material Icons, Lucide, Feather, etc.)
  - Comprehensive documentation and examples

### Enhanced
- **Documentation**: Added new tooltip component documentation
  - Complete API reference with usage examples
  - Visual component showcase with screenshots
  - Integration examples in documentation site

### Fixed
- **Component Consistency**: Improved naming consistency across all components
- **Documentation Updates**: Enhanced component documentation with latest features

## [0.4.0] - 2025-08-18

### Added
- **HuxDateInput**: New date input component with automatic formatting
  - Automatic '/' insertion for date input (MM/DD/YYYY format)
  - Integrated calendar icon that opens date picker overlay directly
  - Compact, square calendar icon with minimal padding
  - Form validation and error handling
  - Consistent styling with other input components
- **HuxInput**: Renamed from HuxTextField for better naming consistency
  - More intuitive and concise component name
  - Maintains all existing functionality and API
  - Better alignment with modern UI library naming conventions

### Enhanced
- **HuxButton**: Added icon-only button support with square dimensions
  - New `HuxButtonWidth` enum for precise width control (hug, expand, fixed)
  - Icon-only buttons automatically remove padding and hover effects
  - Square button support for consistent icon presentation
- **HuxDatePicker**: Enhanced with icon-only mode for text field integration
  - `showText` parameter for calendar-only display
  - Ghost variant support for seamless text field integration
  - Compact sizing for suffix icon usage

### Improved
- **Button Hover States**: Enhanced primary button hover with subtle grey overlay
  - Uses `HuxTokens.buttonPrimaryHover` for consistent theming
  - Adaptive hover effects based on button variant
- **Text Field Sizing**: Simplified to single consistent size for better UX
  - Fixed 40px height for all text fields
  - Consistent padding and icon sizing
  - Better alignment with button heights

### Fixed
- **Component Naming**: Standardized component names for better developer experience
- **Icon Positioning**: Improved calendar icon centering and sizing in date fields
- **Height Consistency**: Resolved text field height discrepancies across components

### Breaking Changes
- **HuxTextField → HuxInput**: Component renamed for better naming consistency
  - Update imports from `HuxTextField` to `HuxInput`
  - All functionality remains identical

## [0.3.2] - 2025-08-14

### Improvements
- Upgraded dependencies cristalyse to 1.1.0

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