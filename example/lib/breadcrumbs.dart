import 'package:flutter/material.dart';
import 'package:hux/hux.dart';

class BreadcrumbsSection extends StatefulWidget {
  const BreadcrumbsSection({super.key});

  @override
  State<BreadcrumbsSection> createState() => _BreadcrumbsSectionState();
}

class _BreadcrumbsSectionState extends State<BreadcrumbsSection> {
  HuxBreadcrumbVariant _selectedVariant = HuxBreadcrumbVariant.default_;
  HuxBreadcrumbSize _selectedSize = HuxBreadcrumbSize.medium;

  @override
  Widget build(BuildContext context) {
    return HuxCard(
      title: 'Breadcrumbs',
      subtitle: 'Show users their current location and provide easy navigation',
      action: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Variant:',
            style: TextStyle(
              color: HuxTokens.textSecondary(context),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: HuxDropdown<HuxBreadcrumbVariant>(
              items: const [
                HuxDropdownItem(
                  value: HuxBreadcrumbVariant.default_,
                  child: Text('Default'),
                ),
                HuxDropdownItem(
                  value: HuxBreadcrumbVariant.icon,
                  child: Text('Icon'),
                ),
              ],
              value: _selectedVariant,
              onChanged: (value) {
                setState(() {
                  _selectedVariant = value;
                });
              },
              placeholder: 'Select variant',
              variant: HuxButtonVariant.outline,
              size: HuxButtonSize.small,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Size:',
            style: TextStyle(
              color: HuxTokens.textSecondary(context),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: HuxDropdown<HuxBreadcrumbSize>(
              items: const [
                HuxDropdownItem(
                  value: HuxBreadcrumbSize.small,
                  child: Text('Small'),
                ),
                HuxDropdownItem(
                  value: HuxBreadcrumbSize.medium,
                  child: Text('Medium'),
                ),
                HuxDropdownItem(
                  value: HuxBreadcrumbSize.large,
                  child: Text('Large'),
                ),
              ],
              value: _selectedSize,
              onChanged: (value) {
                setState(() {
                  _selectedSize = value;
                });
              },
              placeholder: 'Select size',
              variant: HuxButtonVariant.outline,
              size: HuxButtonSize.small,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Basic breadcrumbs example
          Text(
            'Basic Example',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: HuxTokens.textPrimary(context),
                ),
          ),
          const SizedBox(height: 12),
          HuxBreadcrumbs(
            variant: _selectedVariant,
            size: _selectedSize,
            items: [
              HuxBreadcrumbItem(
                label: 'Home',
                onTap: () => _showSnackbar('Navigated to Home'),
                icon: LucideIcons.home,
              ),
              HuxBreadcrumbItem(
                label: 'Products',
                onTap: () => _showSnackbar('Navigated to Products'),
              ),
              HuxBreadcrumbItem(
                label: 'Electronics',
                onTap: () => _showSnackbar('Navigated to Electronics'),
              ),
              HuxBreadcrumbItem(
                label: 'Smartphones',
                onTap: () => _showSnackbar('Navigated to Smartphones'),
              ),
              HuxBreadcrumbItem(
                label: 'iPhone 15 Pro',
                onTap: () {},
                isActive: true,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Overflow example
          Text(
            'With Overflow',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: HuxTokens.textPrimary(context),
                ),
          ),
          const SizedBox(height: 12),
          HuxBreadcrumbs(
            variant: _selectedVariant,
            size: _selectedSize,
            maxItems: 3,
            overflowIndicator: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: HuxTokens.surfaceSecondary(context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '...',
                style: TextStyle(
                  color: HuxTokens.textSecondary(context),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            items: [
              HuxBreadcrumbItem(
                label: 'Home',
                onTap: () => _showSnackbar('Navigated to Home'),
                icon: LucideIcons.home,
              ),
              HuxBreadcrumbItem(
                label: 'Products',
                onTap: () => _showSnackbar('Navigated to Products'),
              ),
              HuxBreadcrumbItem(
                label: 'Electronics',
                onTap: () => _showSnackbar('Navigated to Electronics'),
              ),
              HuxBreadcrumbItem(
                label: 'Smartphones',
                onTap: () => _showSnackbar('Navigated to Smartphones'),
              ),
              HuxBreadcrumbItem(
                label: 'Apple',
                onTap: () => _showSnackbar('Navigated to Apple'),
              ),
              HuxBreadcrumbItem(
                label: 'iPhone 15 Pro',
                onTap: () {},
                isActive: true,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Disabled variant intentionally hidden in examples
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    context.showHuxSnackbar(
      message: message,
      variant: HuxSnackbarVariant.info,
    );
  }
}
