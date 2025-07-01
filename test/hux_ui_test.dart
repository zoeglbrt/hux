import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hux/hux.dart';

void main() {
  group('Hux UI Components Tests', () {
    testWidgets('HuxButton renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxButton(
              onPressed: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(HuxButton), findsOneWidget);
    });

    testWidgets('HuxTextField renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HuxTextField(
              label: 'Test Field',
              hint: 'Enter text',
            ),
          ),
        ),
      );

      expect(find.text('Test Field'), findsOneWidget);
      expect(find.byType(HuxTextField), findsOneWidget);
    });

    testWidgets('HuxCard renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HuxCard(
              title: 'Test Card',
              child: Text('Card content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Card'), findsOneWidget);
      expect(find.text('Card content'), findsOneWidget);
      expect(find.byType(HuxCard), findsOneWidget);
    });

    testWidgets('HuxLoading renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HuxLoading(),
          ),
        ),
      );

      expect(find.byType(HuxLoading), findsOneWidget);
    });

    testWidgets('HuxButton variant tests', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                HuxButton(
                  onPressed: () {},
                  variant: HuxButtonVariant.primary,
                  child: const Text('Primary'),
                ),
                HuxButton(
                  onPressed: () {},
                  variant: HuxButtonVariant.secondary,
                  child: const Text('Secondary'),
                ),
                HuxButton(
                  onPressed: () {},
                  variant: HuxButtonVariant.outline,
                  child: const Text('Outline'),
                ),
                HuxButton(
                  onPressed: () {},
                  variant: HuxButtonVariant.ghost,
                  child: const Text('Ghost'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Outline'), findsOneWidget);
      expect(find.text('Ghost'), findsOneWidget);
      expect(find.byType(HuxButton), findsNWidgets(4));
    });

    testWidgets('HuxButton size variants', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                HuxButton(
                  onPressed: () {},
                  size: HuxButtonSize.small,
                  child: const Text('Small'),
                ),
                HuxButton(
                  onPressed: () {},
                  size: HuxButtonSize.medium,
                  child: const Text('Medium'),
                ),
                HuxButton(
                  onPressed: () {},
                  size: HuxButtonSize.large,
                  child: const Text('Large'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
      expect(find.text('Medium'), findsOneWidget);
      expect(find.text('Large'), findsOneWidget);
      expect(find.byType(HuxButton), findsNWidgets(3));
    });

    testWidgets('HuxTextField validation', (WidgetTester tester) async {
      final controller = TextEditingController();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: HuxTextField(
                controller: controller,
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(HuxTextField), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('HuxLoading sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                HuxLoading(size: HuxLoadingSize.small),
                HuxLoading(size: HuxLoadingSize.medium),
                HuxLoading(size: HuxLoadingSize.large),
                HuxLoading(size: HuxLoadingSize.extraLarge),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(HuxLoading), findsNWidgets(4));
    });

    testWidgets('HuxCard with subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HuxCard(
              title: 'Card Title',
              subtitle: 'Card subtitle',
              child: Text('Card body'),
            ),
          ),
        ),
      );

      expect(find.text('Card Title'), findsOneWidget);
      expect(find.text('Card subtitle'), findsOneWidget);
      expect(find.text('Card body'), findsOneWidget);
    });
  });
}
