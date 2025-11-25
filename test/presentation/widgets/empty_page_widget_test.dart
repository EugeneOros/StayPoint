import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_booking_app/presentation/widgets/empty_page_widget.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('EmptyPageWidget', () {
    const testImagePath = 'assets/icons/test.svg';
    const testTitle = 'Test Title';
    const testSubtitle = 'Test Subtitle';
    const testImageWidth = 300.0;
    const testImageHeight = 300.0;

    testWidgets('displays title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: EmptyPageWidget(
              imagePath: testImagePath,
              title: testTitle,
              subtitle: testSubtitle,
            ),
          ),
        ),
      );

      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testSubtitle), findsOneWidget);
    });

    testWidgets('displays SVG image', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: EmptyPageWidget(
              imagePath: testImagePath,
              title: testTitle,
              subtitle: testSubtitle,
            ),
          ),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('uses default image dimensions when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: EmptyPageWidget(
              imagePath: testImagePath,
              title: testTitle,
              subtitle: testSubtitle,
            ),
          ),
        ),
      );

      final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(svgWidget.width, 200);
      expect(svgWidget.height, 200);
    });

    testWidgets('uses custom image dimensions when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: EmptyPageWidget(
              imagePath: testImagePath,
              title: testTitle,
              subtitle: testSubtitle,
              imageWidth: testImageWidth,
              imageHeight: testImageHeight,
            ),
          ),
        ),
      );

      final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(svgWidget.width, testImageWidth);
      expect(svgWidget.height, testImageHeight);
    });

    testWidgets('is centered in the screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: EmptyPageWidget(
              imagePath: testImagePath,
              title: testTitle,
              subtitle: testSubtitle,
            ),
          ),
        ),
      );

      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('texts are center aligned', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            body: EmptyPageWidget(
              imagePath: testImagePath,
              title: testTitle,
              subtitle: testSubtitle,
            ),
          ),
        ),
      );

      final titleFinder = find.text(testTitle);
      final subtitleFinder = find.text(testSubtitle);

      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      final subtitleWidget = tester.widget<Text>(subtitleFinder);

      expect(titleWidget.textAlign, TextAlign.center);
      expect(subtitleWidget.textAlign, TextAlign.center);
    });
  });
}
