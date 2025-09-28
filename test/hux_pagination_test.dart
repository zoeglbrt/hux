import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hux/src/components/buttons/hux_button.dart';
import 'package:hux/src/components/pagination/hux_pagination.dart';

void main() {
  group('HuxPagination', () {
    testWidgets('renders correctly with initial page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxPagination(
              currentPage: 1,
              totalPages: 5,
              onPageChanged: (int page) {},
            ),
          ),
        ),
      );

      expect(find.byType(HuxPagination), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('calls onPageChanged when a page button is tapped',
        (WidgetTester tester) async {
      int? selectedPage;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxPagination(
              currentPage: 1,
              totalPages: 5,
              onPageChanged: (int page) {
                selectedPage = page;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('3'));
      await tester.pump();

      expect(selectedPage, 3);
    });

    testWidgets('disables previous button on the first page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxPagination(
              currentPage: 1,
              totalPages: 5,
              onPageChanged: (int page) {},
            ),
          ),
        ),
      );

      final Finder prevButtonFinder =
          find.widgetWithIcon(HuxButton, FeatherIcons.chevronLeft);
      expect(prevButtonFinder, findsOneWidget);

      final HuxButton button = tester.widget<HuxButton>(prevButtonFinder);
      expect(button.onPressed, isNull);
    });

    testWidgets('disables next button on the last page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxPagination(
              currentPage: 5,
              totalPages: 5,
              onPageChanged: (int page) {},
            ),
          ),
        ),
      );

      final Finder nextButtonFinder =
          find.widgetWithIcon(HuxButton, FeatherIcons.chevronRight);
      expect(nextButtonFinder, findsOneWidget);

      final HuxButton button = tester.widget<HuxButton>(nextButtonFinder);
      expect(button.onPressed, isNull);
    });

    testWidgets('displays ellipses when there are many pages',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxPagination(
              currentPage: 10,
              totalPages: 20,
              onPageChanged: (int page) {},
            ),
          ),
        ),
      );

      expect(find.text('...'), findsWidgets);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('20'), findsOneWidget);
    });

    testWidgets('highlights the current page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HuxPagination(
              currentPage: 3,
              totalPages: 5,
              onPageChanged: (int page) {},
            ),
          ),
        ),
      );
      final HuxButton selectedButton = tester.widget(
        find.ancestor(
          of: find.text('3'),
          matching: find.byType(HuxButton),
        ),
      );
      expect(selectedButton.variant, HuxButtonVariant.primary);
      final HuxButton unselectedButton = tester.widget(
        find.ancestor(
          of: find.text('2'),
          matching: find.byType(HuxButton),
        ),
      );
      expect(unselectedButton.variant, HuxButtonVariant.ghost);
    });
  });
}
