import 'package:flutter/widgets.dart';

class AppMeasurements {
  late final bool isMobile;
  late final double deviceHeight;
  late final double deviceWidth;
  late final double safeAreaHeight;
  late final EdgeInsets safeAreaPadding;

  static late AppMeasurements instance;
  factory AppMeasurements() => instance;
  AppMeasurements._internal();

  static void setAppMeasurements(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final safeArea = mediaQuery.padding;

    instance = AppMeasurements._internal()
      ..isMobile = mediaQuery.size.width < 600
      ..deviceHeight = mediaQuery.size.height
      ..deviceWidth = mediaQuery.size.width
      ..safeAreaPadding = safeArea
      ..safeAreaHeight =
          mediaQuery.size.height - safeArea.top - safeArea.bottom;
  }
}

extension ExtensionMedidasAplicativo on num {
  /// Percentage of device width (0-100)
  double get w => AppMeasurements.instance.deviceWidth * (this / 100);

  /// Percentage of device height (0-100)
  double get h => AppMeasurements.instance.deviceHeight * (this / 100);

  /// Percentage of safe area height (0-100)
  double get hSafe => AppMeasurements.instance.safeAreaHeight * (this / 100);

  /// Scaled pixels based on device height (base: 844px - iPhone 14 Pro)
  double get sp => this * (AppMeasurements.instance.deviceHeight / 844);
}
