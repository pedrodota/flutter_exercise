import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:formfun_flutter_test/core/theme/app_theme.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      home: const _HomeWidget(),
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: AppTheme.lightTheme,
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: AppTheme.darkTheme,
            ),
          ],
        ),
        ViewportAddon([
          ViewportData(
            name: 'iPhone 6',
            width: 375,
            height: 667,
            pixelRatio: 2,
            platform: TargetPlatform.iOS,
          ),
          ViewportData(
            name: 'iPhone 16 Pro',
            width: 402,
            height: 874,
            pixelRatio: 3,
            platform: TargetPlatform.iOS,
          ),
          ViewportData(
            name: 'iPhone 16 Pro Max',
            width: 440,
            height: 956,
            pixelRatio: 3,
            platform: TargetPlatform.iOS,
          ),
          ViewportData(
            name: 'Tablet',
            width: 1024,
            height: 768,
            pixelRatio: 2,
            platform: TargetPlatform.iOS,
          ),
          ViewportData(
            name: 'Tablet Vertical',
            width: 768,
            height: 1024,
            pixelRatio: 2,
            platform: TargetPlatform.iOS,
          ),
        ]),
      ],
    );
  }
}

class _HomeWidget extends StatefulWidget {
  const _HomeWidget();

  @override
  State<_HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<_HomeWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isDark = false;
  String? _expandedSection;

  // Dados para exibição
  static const _devices = [
    ('iPhone 6', '375 x 667'),
    ('iPhone 16 Pro', '402 x 874'),
    ('iPhone 16 Pro Max', '440 x 956'),
    ('Tablet', '1024 x 768'),
    ('Tablet Vertical', '768 x 1024'),
  ];

  static const _knobs = [
    ('String', 'Textos editáveis'),
    ('Boolean', 'Toggle on/off'),
    ('Slider', 'Valores numéricos'),
    ('Options', 'Lista de opções'),
  ];

  static const _languages = [
    ('Português', 'pt_BR'),
    ('English', 'en_US'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
      _expandedSection = _expandedSection == 'theme' ? null : 'theme';
    });
  }

  void _toggleSection(String section) {
    setState(() {
      _expandedSection = _expandedSection == section ? null : section;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _isDark ? darkBackground : masterColorA;
    final textColor = _isDark ? darkTextPrimary : darkColor;
    final subtitleColor = _isDark ? darkTextSecondary : taglineColor;
    final chipBgColor = _isDark ? masterColorB : darkColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _playAnimation,
                child: Lottie.asset(
                  'assets/animations/formAndFun_lottie.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller.duration = composition.duration;
                    _controller.forward();
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Form&Fun Widgetbook',
                style: TextStyle(
                  fontFamily: fontAktivGrotesk,
                  fontSize: 28,
                  fontWeight: boldWeight,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Explore os componentes do app Form&Fun.\nSelecione um widget no menu lateral.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: fontAktivGrotesk,
                  fontSize: 16,
                  fontWeight: regularWeight,
                  color: subtitleColor,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _FeatureChip(
                    icon: _isDark ? Icons.light_mode : Icons.dark_mode,
                    label: _isDark ? 'Light Mode' : 'Dark Mode',
                    isActive: _expandedSection == 'theme',
                    bgColor: chipBgColor,
                    onTap: _toggleTheme,
                  ),
                  _FeatureChip(
                    icon: Icons.phone_android,
                    label: 'Devices',
                    isActive: _expandedSection == 'devices',
                    bgColor: chipBgColor,
                    onTap: () => _toggleSection('devices'),
                  ),
                  _FeatureChip(
                    icon: Icons.tune,
                    label: 'Knobs',
                    isActive: _expandedSection == 'knobs',
                    bgColor: chipBgColor,
                    onTap: () => _toggleSection('knobs'),
                  ),
                  _FeatureChip(
                    icon: Icons.language,
                    label: 'i18n',
                    isActive: _expandedSection == 'i18n',
                    bgColor: chipBgColor,
                    onTap: () => _toggleSection('i18n'),
                  ),
                ],
              ),
              // Expanded sections
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: _buildExpandedSection(textColor, subtitleColor, chipBgColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedSection(Color textColor, Color subtitleColor, Color chipBgColor) {
    if (_expandedSection == null || _expandedSection == 'theme') {
      return const SizedBox.shrink();
    }

    List<(String, String)> items;
    String title;
    IconData icon;

    switch (_expandedSection) {
      case 'devices':
        items = _devices;
        title = 'Dispositivos disponíveis';
        icon = Icons.phone_android;
        break;
      case 'knobs':
        items = _knobs;
        title = 'Tipos de Knobs';
        icon = Icons.tune;
        break;
      case 'i18n':
        items = _languages;
        title = 'Idiomas configurados';
        icon = Icons.language;
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: chipBgColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipBgColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: textColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontFamily: fontAktivGrotesk,
                  fontSize: 14,
                  fontWeight: semiBoldWeight,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: masterColorB,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.$1,
                  style: TextStyle(
                    fontFamily: fontAktivGrotesk,
                    fontSize: 13,
                    fontWeight: mediumWeight,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.$2,
                  style: TextStyle(
                    fontFamily: fontAktivGrotesk,
                    fontSize: 12,
                    fontWeight: regularWeight,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color bgColor;
  final VoidCallback onTap;

  const _FeatureChip({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? masterColorB : bgColor,
          borderRadius: BorderRadius.circular(20),
          border: isActive ? Border.all(color: lightColor, width: 2) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: lightColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontFamily: fontAktivGrotesk,
                fontSize: 12,
                fontWeight: mediumWeight,
                color: lightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
