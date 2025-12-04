import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/widgets/exercise_1_card_widget.dart';

@widgetbook.UseCase(name: 'Default', type: Exercise1CardWidget)
Widget buildExercise1CardWidget(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Loading File',
  );
  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: '1m 30s',
  );
  final percentage = context.knobs.double.slider(
    label: 'Percentage',
    initialValue: 50,
    min: 0,
    max: 100,
  );

  return MediaQuery(
    data: const MediaQueryData(size: Size(390, 844)),
    child: Builder(
      builder: (ctx) {
        AppMeasurements.setAppMeasurements(ctx);

        return Scaffold(
          backgroundColor: appBackground,
          body: Center(
            child: Exercise1CardWidget(
              title: title,
              subtitle: subtitle,
              percentage: percentage,
            ),
          ),
        );
      },
    ),
  );
}

