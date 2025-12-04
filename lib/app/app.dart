import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/app/routes.dart';
import 'package:formfun_flutter_test/core/l10n/app_translations.dart';
import 'package:formfun_flutter_test/core/theme/app_theme.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/pages/exercise_1_page.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/pages/exercise_2_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Detecta o idioma do sistema
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    final locale = systemLocale.languageCode == 'pt'
        ? const Locale('pt', 'BR')
        : const Locale('en', 'US');

    return GetMaterialApp(
      title: 'Form&Fun Flutter Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // Internationalization
      translations: AppTranslations(),
      locale: locale,
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppRoutes.exercise1,
      onGenerateRoute: _onGenerateRoute,
      builder: (context, child) {
        AppMeasurements.setAppMeasurements(context);
        return child ?? const SizedBox.shrink();
      },
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.exercise1:
        return MaterialPageRoute(
          builder: (_) => const Exercise1Page(),
        );
      case AppRoutes.exercise2:
        return MaterialPageRoute(
          builder: (_) => const Exercise2Page(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Exercise1Page(),
        );
    }
  }
}
