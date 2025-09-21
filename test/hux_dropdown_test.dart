import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hux/hux.dart';

void main() {
  group('HuxDropdown', () {
    final items = [
      const HuxDropdownItem(
        value: 'item1',
        child: Text('Item 1'),
      ),
      const HuxDropdownItem(
        value: 'item2',
        child: Text('Item 2'),
      ),
      const HuxDropdownItem(
        value: 'item3',
        child: Text('Item 3'),
      ),
    ];

    testWidgets('renders with placeholder when no value selected',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: HuxDropdown<String>(
              items: items,
              value: null,
              onChanged: (_) {},
              placeholder: 'Select',
            ),
          ),
        ),
      );

      expect(find.text('Select'), findsOneWidget);
      expect(find.text('Item 1'), findsNothing);
    });

    testWidgets('renders selected value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: HuxDropdown<String>(
              items: items,
              value: 'item1',
              onChanged: (_) {},
              placeholder: 'Select',
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Select'), findsNothing);
    });

    testWidgets('opens dropdown on tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: HuxDropdown<String>(
              items: items,
              value: null,
              onChanged: (_) {},
              placeholder: 'Select',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(HuxDropdown<String>));
      await tester.pumpAndSettle();

      // All items should be visible in the dropdown panel
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('calls onChanged when item selected', (tester) async {
      String? selectedValue;
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: HuxDropdown<String>(
              items: items,
              value: null,
              onChanged: (value) => selectedValue = value,
              placeholder: 'Select',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(HuxDropdown<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle();

      expect(selectedValue, equals('item2'));
    });

    testWidgets('disabled state prevents interaction', (tester) async {
      String? selectedValue;
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: HuxDropdown<String>(
              items: items,
              value: null,
              onChanged: (value) => selectedValue = value,
              placeholder: 'Select',
              enabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(HuxDropdown<String>));
      await tester.pumpAndSettle();

      // Dropdown should not open
      expect(find.text('Item 1'), findsNothing);
      expect(selectedValue, isNull);
    });

    testWidgets('supports different variants', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: [
                HuxDropdown<String>(
                  items: items,
                  value: null,
                  onChanged: (_) {},
                  placeholder: 'Select',
                  variant: HuxButtonVariant.primary,
                ),
                HuxDropdown<String>(
                  items: items,
                  value: null,
                  onChanged: (_) {},
                  placeholder: 'Select',
                  variant: HuxButtonVariant.secondary,
                ),
                HuxDropdown<String>(
                  items: items,
                  value: null,
                  onChanged: (_) {},
                  placeholder: 'Select',
                  variant: HuxButtonVariant.outline,
                ),
                HuxDropdown<String>(
                  items: items,
                  value: null,
                  onChanged: (_) {},
                  placeholder: 'Select',
                  variant: HuxButtonVariant.ghost,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(HuxDropdown<String>), findsNWidgets(4));
    });

    testWidgets('supports different sizes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: [
                HuxDropdown<String>(
                  items: items,
                  value: null,
                  onChanged: (_) {},
                  placeholder: 'Select',
                  size: HuxButtonSize.small,
                ),
                HuxDropdown<String>(
                  items: items,
                  value: null,
                  onChanged: (_) {},
                  placeholder: 'Select',
                  size: HuxButtonSize.medium,
                ),
                HuxDropdown<String>(
                  items: items,
                  value: null,
                  onChanged: (_) {},
                  placeholder: 'Select',
                  size: HuxButtonSize.large,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(HuxDropdown<String>), findsNWidgets(3));
    });

    testWidgets('supports custom primary color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: HuxDropdown<String>(
              items: items,
              value: null,
              onChanged: (_) {},
              placeholder: 'Select',
              variant: HuxButtonVariant.primary,
              primaryColor: Colors.purple,
            ),
          ),
        ),
      );

      expect(find.byType(HuxDropdown<String>), findsOneWidget);
    });

    testWidgets('supports icons in items', (tester) async {
      final itemsWithIcons = [
        const HuxDropdownItem(
          value: 'user',
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 8),
              Text('User'),
            ],
          ),
        ),
        const HuxDropdownItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 8),
              Text('Settings'),
            ],
          ),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          home: Scaffold(
            body: HuxDropdown<String>(
              items: itemsWithIcons,
              value: null,
              onChanged: (_) {},
              placeholder: 'Select',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(HuxDropdown<String>));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });
}
