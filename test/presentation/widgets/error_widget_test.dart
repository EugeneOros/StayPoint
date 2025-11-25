import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_booking_app/core/assets/assets.dart';
import 'package:hotel_booking_app/presentation/widgets/error_widget.dart';
import 'package:hotel_booking_app/presentation/widgets/empty_page_widget.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('ErrorWidget', () {
    const testMessage = 'Test error message';

    testWidgets('displays error message', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: ErrorWidget(message: testMessage),
          ),
        ),
      );

      expect(find.text(testMessage), findsOneWidget);
    });

    testWidgets('displays error title', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: ErrorWidget(message: testMessage),
          ),
        ),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('uses EmptyPageWidget with error SVG', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: ErrorWidget(message: testMessage),
          ),
        ),
      );

      expect(find.byType(EmptyPageWidget), findsOneWidget);
      final emptyWidget = tester.widget<EmptyPageWidget>(find.byType(EmptyPageWidget));
      expect(emptyWidget.imagePath, Assets.icons.error);
      expect(emptyWidget.subtitle, testMessage);
    });

    testWidgets('displays retry button when onRetry is provided', (WidgetTester tester) async {
      bool retryPressed = false;

      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: ErrorWidget(
              message: testMessage,
              onRetry: () {
                retryPressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(retryPressed, isTrue);
    });

    testWidgets('does not display retry button when onRetry is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: ErrorWidget(message: testMessage),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('displays SVG image', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: ErrorWidget(message: testMessage),
          ),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}

