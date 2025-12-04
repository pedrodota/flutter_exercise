import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_footer_card_widget.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_main_card_widget.dart';

void main() {
  Widget createTestApp(Widget child) {
    return GetMaterialApp(
      home: Builder(
        builder: (context) {
          AppMeasurements.setAppMeasurements(context);
          return Scaffold(body: Center(child: child));
        },
      ),
    );
  }

  group('Exercise2MainCardWidget', () {
    testWidgets('should display title and subtitle', (tester) async {
      await tester.pumpWidget(createTestApp(
        const Exercise2MainCardWidget(
          imageAsset: 'assets/images/ff_website.png',
          title: 'Test Title',
          subtitle: 'Test Subtitle',
          buttonText: 'View',
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('should display button text', (tester) async {
      await tester.pumpWidget(createTestApp(
        const Exercise2MainCardWidget(
          imageAsset: 'assets/images/ff_website.png',
          title: 'Title',
          subtitle: 'Subtitle',
          buttonText: 'Open',
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Open'), findsOneWidget);
    });

    testWidgets('should have Semantics label', (tester) async {
      await tester.pumpWidget(createTestApp(
        const Exercise2MainCardWidget(
          imageAsset: 'assets/images/ff_website.png',
          title: 'My Card',
          subtitle: 'Description',
          buttonText: 'View',
        ),
      ));
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(find.byType(Exercise2MainCardWidget));
      expect(semantics.label, contains('Landing page card'));
      expect(semantics.label, contains('My Card'));
    });

    testWidgets('should call onButtonPressed callback when button tapped', (tester) async {
      var wasPressed = false;

      await tester.pumpWidget(createTestApp(
        Exercise2MainCardWidget(
          imageAsset: 'assets/images/ff_website.png',
          title: 'Title',
          subtitle: 'Subtitle',
          buttonText: 'View',
          onButtonPressed: () => wasPressed = true,
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.text('View'));
      await tester.pumpAndSettle();

      expect(wasPressed, true);
    });
  });

  group('Exercise2FooterCardWidget', () {
    testWidgets('should display title and subtitle', (tester) async {
      await tester.pumpWidget(createTestApp(
        const Exercise2FooterCardWidget(
          logoAsset: 'assets/images/ff_logo.png',
          title: 'Form&Fun',
          subtitle: 'formandfun.co',
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Form&Fun'), findsOneWidget);
      expect(find.text('formandfun.co'), findsOneWidget);
    });

    testWidgets('should have Semantics as button', (tester) async {
      await tester.pumpWidget(createTestApp(
        const Exercise2FooterCardWidget(
          logoAsset: 'assets/images/ff_logo.png',
          title: 'Form&Fun',
          subtitle: 'formandfun.co',
        ),
      ));
      await tester.pumpAndSettle();

      final semantics = tester.getSemantics(find.byType(Exercise2FooterCardWidget));
      expect(semantics.label, contains('Open Form&Fun website'));
    });

    testWidgets('should call onTap callback when tapped', (tester) async {
      var wasTapped = false;

      await tester.pumpWidget(createTestApp(
        Exercise2FooterCardWidget(
          logoAsset: 'assets/images/ff_logo.png',
          title: 'Form&Fun',
          subtitle: 'formandfun.co',
          onTap: () => wasTapped = true,
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Exercise2FooterCardWidget));
      await tester.pumpAndSettle();

      expect(wasTapped, true);
    });

    testWidgets('should animate scale on tap down', (tester) async {
      await tester.pumpWidget(createTestApp(
        const Exercise2FooterCardWidget(
          logoAsset: 'assets/images/ff_logo.png',
          title: 'Form&Fun',
          subtitle: 'formandfun.co',
        ),
      ));
      await tester.pumpAndSettle();

      // Find AnimatedScale widget
      expect(find.byType(AnimatedScale), findsOneWidget);
    });
  });
}
