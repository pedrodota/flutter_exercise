// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_workspace/exercise_1.dart'
    as _widgetbook_workspace_exercise_1;
import 'package:widgetbook_workspace/exercise_2.dart'
    as _widgetbook_workspace_exercise_2;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'features',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'exercise_1',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'widgets',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'Exercise1CardWidget',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default',
                        builder: _widgetbook_workspace_exercise_1
                            .buildExercise1CardWidget,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _widgetbook.WidgetbookFolder(
        name: 'exercise_2',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'widgets',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'Exercise2BlurOverlayWidget',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Blur Overlay',
                        builder: _widgetbook_workspace_exercise_2
                            .buildExercise2BlurOverlayWidget,
                      ),
                    ],
                  ),
                  _widgetbook.WidgetbookComponent(
                    name: 'Exercise2FooterCardWidget',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Footer Card',
                        builder: _widgetbook_workspace_exercise_2
                            .buildExercise2FooterCardWidget,
                      ),
                    ],
                  ),
                  _widgetbook.WidgetbookComponent(
                    name: 'Exercise2MainCardWidget',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Main Card',
                        builder: _widgetbook_workspace_exercise_2
                            .buildExercise2MainCardWidget,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
