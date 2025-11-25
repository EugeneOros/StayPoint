import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking_app/presentation/widgets/loading_widget.dart';
import 'package:hotel_booking_app/theme/colors.dart';

void main() {
  group('LoadingWidget', () {
    testWidgets('displays CircularProgressIndicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LoadingWidget())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('CircularProgressIndicator has correct color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LoadingWidget())),
      );

      final circularProgressIndicator = tester
          .widget<CircularProgressIndicator>(
            find.byType(CircularProgressIndicator),
          );

      expect(circularProgressIndicator.color, AppColors.backgroundBrand);
    });

    testWidgets('is centered in the screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LoadingWidget())),
      );

      expect(find.byType(Center), findsOneWidget);
    });
  });
}
