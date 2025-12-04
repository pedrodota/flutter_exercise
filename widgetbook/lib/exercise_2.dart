import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_main_card_widget.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_footer_card_widget.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_blur_overlay_widget.dart';

// Assets paths locais do widgetbook
const _ffWebsite = 'assets/images/ff_website.png';
const _ffLogo = 'assets/images/ff_logo.png';

@widgetbook.UseCase(name: 'Main Card', type: Exercise2MainCardWidget)
Widget buildExercise2MainCardWidget(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Form&Fun',
  );
  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'formfun.ai',
  );
  final buttonText = context.knobs.string(
    label: 'Button Text',
    initialValue: 'Open',
  );

  return MediaQuery(
    data: const MediaQueryData(size: Size(390, 844)),
    child: Builder(
      builder: (ctx) {
        AppMeasurements.setAppMeasurements(ctx);

        return Scaffold(
          backgroundColor: ctx.backgroundColor,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Exercise2MainCardWidget(
                imageAsset: _ffWebsite,
                title: title,
                subtitle: subtitle,
                buttonText: buttonText,
              ),
            ),
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Footer Card', type: Exercise2FooterCardWidget)
Widget buildExercise2FooterCardWidget(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Form&Fun',
  );
  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'formfun.ai',
  );

  return MediaQuery(
    data: const MediaQueryData(size: Size(390, 844)),
    child: Builder(
      builder: (ctx) {
        AppMeasurements.setAppMeasurements(ctx);

        return Scaffold(
          backgroundColor: ctx.backgroundColor,
          body: Center(
            child: Exercise2FooterCardWidget(
              logoAsset: _ffLogo,
              title: title,
              subtitle: subtitle,
            ),
          ),
        );
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Blur Overlay', type: Exercise2BlurOverlayWidget)
Widget buildExercise2BlurOverlayWidget(BuildContext context) {
  final height = context.knobs.double.slider(
    label: 'Height',
    initialValue: 150,
    min: 50,
    max: 300,
  );

  return MediaQuery(
    data: const MediaQueryData(size: Size(390, 844)),
    child: Builder(
      builder: (ctx) {
        AppMeasurements.setAppMeasurements(ctx);

        return Scaffold(
          backgroundColor: ctx.backgroundColor,
          body: Stack(
            children: [
              // Content behind blur
              ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
              // Blur overlay at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Exercise2BlurOverlayWidget(height: height),
              ),
            ],
          ),
        );
      },
    ),
  );
}
