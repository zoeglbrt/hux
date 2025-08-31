import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hux/hux.dart';

void main() {
  group('HuxDialog', () {
    testWidgets('renders with title and content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDialog(
              title: 'Test Dialog',
              content: const Text('Test content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Dialog'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('renders with subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDialog(
              title: 'Test Dialog',
              subtitle: 'Test subtitle',
              content: const Text('Test content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Dialog'), findsOneWidget);
      expect(find.text('Test subtitle'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('renders with actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDialog(
              title: 'Test Dialog',
              content: const Text('Test content'),
              actions: [
                HuxButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                HuxButton(
                  onPressed: () {},
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });

    testWidgets('shows close button by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDialog(
              title: 'Test Dialog',
              content: const Text('Test content'),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('hides close button when showCloseButton is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDialog(
              title: 'Test Dialog',
              content: const Text('Test content'),
              showCloseButton: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('applies different sizes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDialog(
              title: 'Test Dialog',
              content: const Text('Test content'),
              size: HuxDialogSize.small,
            ),
          ),
        ),
      );

      // The dialog should render without errors
      expect(find.text('Test Dialog'), findsOneWidget);
    });
  });

  group('showHuxDialog', () {
    testWidgets('shows dialog with showHuxDialog function',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxButton(
              onPressed: () {
                showHuxDialog<void>(
                  context: tester.element(find.byType(HuxButton)),
                  title: 'Test Dialog',
                  content: const Text('Test content'),
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );

      // Tap the button to show the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // The dialog should be visible
      expect(find.text('Test Dialog'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
    });
  });
}
