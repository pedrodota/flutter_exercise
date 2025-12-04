import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/widgets/exercise_1_card_widget.dart';

void main() {
  Widget createWidgetUnderTest({
    String title = 'Loading File',
    String subtitle = '5s',
    double percentage = 50.0,
    bool animateLottie = false,
  }) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          AppMeasurements.setAppMeasurements(context);
          return Scaffold(
            body: Center(
              child: Exercise1CardWidget(
                title: title,
                subtitle: subtitle,
                percentage: percentage,
                animateLottie: animateLottie,
              ),
            ),
          );
        },
      ),
    );
  }

  group('Exercise1CardWidget', () {
    testWidgets('should display title text', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(title: 'Test Title'));
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('should display subtitle text', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(subtitle: '10s'));
      await tester.pumpAndSettle();

      expect(find.text('10s'), findsOneWidget);
    });

    testWidgets('should have Semantics with correct label', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        title: 'Loading File',
        subtitle: '5s',
        percentage: 50.0,
      ));
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(find.byType(Exercise1CardWidget));
      expect(semantics.label, contains('Loading file card'));
      expect(semantics.label, contains('50 percent'));
    });

    testWidgets('should render with 0% percentage', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(percentage: 0.0));
      await tester.pumpAndSettle();

      expect(find.byType(Exercise1CardWidget), findsOneWidget);
    });

    testWidgets('should render with 100% percentage', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(percentage: 100.0));
      await tester.pumpAndSettle();

      expect(find.byType(Exercise1CardWidget), findsOneWidget);
    });
  });
}
