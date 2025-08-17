# Security Policy

## Supported Versions

Hux UI is currently in active development (pre-1.0). We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.2.x   | :white_check_mark: |
| 0.1.x   | :white_check_mark: |
| < 0.1   | :x:                |

**Note**: As Hux UI is still in early development (0.x versions), we recommend always using the latest version to ensure you have the most recent security fixes and improvements.

## What We Consider Security Vulnerabilities

For a Flutter UI component library like Hux UI, security vulnerabilities may include:

- **Input validation issues** in form components (HuxInput, HuxCheckbox, etc.)
- **XSS vulnerabilities** in web implementations of components
- **Data exposure** through improper logging or debugging output
- **Theme/styling injection** that could allow malicious content rendering
- **Dependency vulnerabilities** in our underlying packages
- **Context menu security** on web platforms (data leakage via context menus)
- **Chart rendering vulnerabilities** that could expose sensitive data

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability in Hux UI, please report it responsibly:

### How to Report

**Email**: [zoe@thehuxdesign.com](mailto:zoe@thehuxdesign.com)

**Subject**: `[SECURITY] Hux UI Vulnerability Report`

### What to Include

Please include the following information in your report:

- **Description** of the vulnerability
- **Steps to reproduce** the issue
- **Affected versions** (if known)
- **Platform(s)** where the issue occurs (Android, iOS, Web, Desktop)
- **Potential impact** and attack scenarios
- **Suggested fix** (if you have one)
- **Your contact information** (if you'd like updates on the fix)

### What to Expect

- **Initial response**: Within 48 hours
- **Status updates**: Every 72 hours until resolution
- **Fix timeline**: We aim to release patches for critical vulnerabilities within 7 days, and moderate vulnerabilities within 30 days

### If Your Report is Accepted

- We'll work with you to understand and reproduce the issue
- We'll develop and test a fix
- We'll release a security update
- We'll acknowledge your contribution (unless you prefer to remain anonymous)
- We'll update this security policy if needed

### If Your Report is Declined

- We'll explain why we don't consider it a security vulnerability
- We might suggest it as a regular bug report or feature request instead
- You're welcome to discuss our assessment if you disagree

## Security Best Practices for Users

When using Hux UI in your applications:

### Input Components
- **Validate user input** on both client and server sides when using HuxInput
- **Sanitize data** before displaying it in components
- **Use proper form validation** with the built-in validator functions

### Web Applications
- **Enable Content Security Policy (CSP)** to prevent XSS attacks
- **Be cautious with user-generated content** in HuxCard titles and content
- **Test context menus** to ensure they don't expose sensitive information

### Data Visualization
- **Sanitize chart data** before passing it to HuxChart components
- **Avoid displaying sensitive information** in chart titles or labels
- **Be mindful of data leakage** through chart interactions

### General
- **Keep Hux UI updated** to the latest version
- **Review dependency vulnerabilities** regularly with tools like `flutter pub audit`
- **Test your app** with security scanners for web deployments

## Dependencies

Hux UI relies on several dependencies. We monitor them for security issues:

- `flutter_feather_icons` - Icon library
- `cristalyse` - Chart rendering engine
- `universal_html` - Web compatibility utilities

We regularly update these dependencies and will release security patches if vulnerabilities are discovered.

## Responsible Disclosure

We follow responsible disclosure practices:

- Security issues are handled privately until a fix is available
- We coordinate with security researchers to ensure proper timing of disclosures
- We aim to balance security with transparency for our users

## Contact

For security-related questions or concerns:

- **Security reports**: [zoe@thehuxdesign.com](mailto:zoe@thehuxdesign.com)
- **General questions**: [GitHub Issues](https://github.com/zoeglbrt/hux/issues) (for non-security issues only)

---

Thank you for helping keep Hux UI and its users safe!
