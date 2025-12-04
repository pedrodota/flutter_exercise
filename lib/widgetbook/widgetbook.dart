import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/widgets/exercise_1_card_widget.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
      ),
      directories: [
        WidgetbookComponent(
          name: 'Exercise1CardWidget',
          useCases: [
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) => Builder(
                builder: (ctx) {
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
                    child: Scaffold(
                      backgroundColor: appBackground,
                      body: Center(
                        child: Exercise1CardWidget(
                          title: title,
                          subtitle: subtitle,
                          percentage: percentage,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
