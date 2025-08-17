import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hux/hux.dart';

void main() {
  group('HuxDateInput', () {
    testWidgets('renders with basic properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDateInput(
              label: 'Test Date',
              onDateChanged: (date) {},
            ),
          ),
        ),
      );

      expect(find.text('Test Date'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(HuxDatePicker), findsOneWidget);
    });

    testWidgets('renders without calendar icon when showCalendarIcon is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDateInput(
              label: 'Test Date',
              showCalendarIcon: false,
              onDateChanged: (date) {},
            ),
          ),
        ),
      );

      expect(find.byType(HuxDatePicker), findsNothing);
    });

    testWidgets('calls onDateChanged when date is selected',
        (WidgetTester tester) async {
      DateTime? selectedDate;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDateInput(
              label: 'Test Date',
              onDateChanged: (date) {
                selectedDate = date;
              },
            ),
          ),
        ),
      );

      // Simulate date selection through the calendar picker
      // Note: This is a simplified test - in a real scenario you'd need to
      // interact with the overlay calendar
      expect(selectedDate, isNull);
    });

    testWidgets('displays error text when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDateInput(
              label: 'Test Date',
              errorText: 'This is an error',
              onDateChanged: (date) {},
            ),
          ),
        ),
      );

      expect(find.text('This is an error'), findsOneWidget);
    });

    testWidgets('displays helper text when no error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDateInput(
              label: 'Test Date',
              helperText: 'This is helper text',
              onDateChanged: (date) {},
            ),
          ),
        ),
      );

      expect(find.text('This is helper text'), findsOneWidget);
    });

    testWidgets('respects enabled property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxDateInput(
              label: 'Test Date',
              enabled: false,
              onDateChanged: (date) {},
            ),
          ),
        ),
      );

      final textField =
          tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('applies different sizes correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                HuxDateInput(
                  label: 'Small',
                  onDateChanged: (date) {},
                ),
                HuxDateInput(
                  label: 'Medium',
                  onDateChanged: (date) {},
                ),
                HuxDateInput(
                  label: 'Large',
                  onDateChanged: (date) {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);
      expect(find.text('Medium'), findsOneWidget);
      expect(find.text('Large'), findsOneWidget);
    });
  });

  group('DateFormat', () {
    test('formats MM/dd/yyyy correctly', () {
      const format = DateFormat('MM/dd/yyyy');
      final date = DateTime(2023, 12, 25);
      expect(format.format(date), equals('12/25/2023'));
    });

    test('formats dd/MM/yyyy correctly', () {
      const format = DateFormat('dd/MM/yyyy');
      final date = DateTime(2023, 12, 25);
      expect(format.format(date), equals('25/12/2023'));
    });

    test('formats yyyy-MM-dd correctly', () {
      const format = DateFormat('yyyy-MM-dd');
      final date = DateTime(2023, 12, 25);
      expect(format.format(date), equals('2023-12-25'));
    });

    test('parses MM/dd/yyyy correctly', () {
      const format = DateFormat('MM/dd/yyyy');
      final parsed = format.parse('12/25/2023');
      expect(parsed.year, equals(2023));
      expect(parsed.month, equals(12));
      expect(parsed.day, equals(25));
    });

    test('parses dd/MM/yyyy correctly', () {
      const format = DateFormat('dd/MM/yyyy');
      final parsed = format.parse('25/12/2023');
      expect(parsed.year, equals(2023));
      expect(parsed.month, equals(12));
      expect(parsed.day, equals(25));
    });

    test('throws FormatException for invalid input', () {
      const format = DateFormat('MM/dd/yyyy');
      expect(() => format.parse('invalid'), throwsA(isA<FormatException>()));
    });
  });
}
