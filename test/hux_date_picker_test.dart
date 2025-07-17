import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hux/hux.dart';

void main() {
  group('Hux Date and Time Picker Tests', () {
    testWidgets('showHuxDatePicker opens and closes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          darkTheme: HuxTheme.darkTheme,
          home: Scaffold(
            body: Builder(
              builder: (context) => HuxButton(
                onPressed: () {
                  showHuxDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                },
                child: const Text('Open Date Picker'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Date Picker'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle(); // Wait for animations

      expect(find.text('OK'), findsNothing);
    });

    testWidgets('showHuxTimePicker opens and closes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: HuxTheme.lightTheme,
          darkTheme: HuxTheme.darkTheme,
          home: Scaffold(
            body: Builder(
              builder: (context) => HuxButton(
                onPressed: () {
                  showHuxTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: const Text('Open Time Picker'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Time Picker'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsNothing);
    });
  });
}
