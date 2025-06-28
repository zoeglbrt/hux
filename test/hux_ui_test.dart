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

    testWidgets('HuxChart renders correctly', (WidgetTester tester) async {
      final testData = [
        {'x': 1, 'y': 10},
        {'x': 2, 'y': 20},
        {'x': 3, 'y': 15},
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxChart(
              data: testData,
              type: HuxChartType.line,
              xField: 'x',
              yField: 'y',
              title: 'Test Chart',
            ),
          ),
        ),
      );

      expect(find.text('Test Chart'), findsOneWidget);
      expect(find.byType(HuxChart), findsOneWidget);
    });

    testWidgets('HuxChart renders with different chart types', (WidgetTester tester) async {
      final testData = [
        {'x': 1, 'y': 10},
        {'x': 2, 'y': 20},
        {'x': 3, 'y': 15},
      ];

      // Test bar chart
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxChart(
              data: testData,
              type: HuxChartType.bar,
              xField: 'x',
              yField: 'y',
              title: 'Bar Chart',
            ),
          ),
        ),
      );

      expect(find.text('Bar Chart'), findsOneWidget);
      expect(find.byType(HuxChart), findsOneWidget);

      // Test line chart
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxChart(
              data: testData,
              type: HuxChartType.line,
              xField: 'x',
              yField: 'y',
              title: 'Line Chart',
            ),
          ),
        ),
      );

      expect(find.text('Line Chart'), findsOneWidget);
      expect(find.byType(HuxChart), findsOneWidget);
    });
  });
} 