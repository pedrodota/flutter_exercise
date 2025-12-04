import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:formfun_flutter_test/core/shared/presentation/backgrounds/base_background.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/text_widget.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/vertical_spacing_widget.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';
import 'package:formfun_flutter_test/core/utils/assets.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:formfun_flutter_test/core/utils/navigator.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/controller/exercise_2_controller.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_blur_overlay_widget.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_footer_card_widget.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/widgets/exercise_2_main_card_widget.dart';

class Exercise2Page extends StatefulWidget {
  const Exercise2Page({super.key});

  @override
  State<Exercise2Page> createState() => _Exercise2PageState();
}

class _Exercise2PageState extends MState<Exercise2Page, Exercise2Controller> {
  DateTime? _lastBackPressTime;
  static const _backPressWindow = Duration(seconds: 2);

  @override
  void initState() {
    registerController(Exercise2Controller());
    super.initState();
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();

    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > _backPressWindow) {
      _lastBackPressTime = now;
      _showExitSnackbar();
      return false;
    }

    SystemNavigator.pop();
    return true;
  }

  void _showExitSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget(
          'Press back again to exit',
          fontSize: context.font_14sp,
          fontWeight: mediumWeight,
          textColor: lightColor,
        ),
        duration: _backPressWindow,
        backgroundColor: darkColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final footerHeight = 68.0;
    final bottomPadding = 16.0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onWillPop();
        }
      },
      child: BaseBackground(
      child: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: controller.scrollController,
            padding: EdgeInsets.symmetric(horizontal: 4.w), // 16px
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (Description section)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w), // 8px
                  child: TextWidget(
                    "Here's your landing page:",
                    fontSize: context.font_20sp,
                    fontWeight: regularWeight,
                    textColor: darkColor,
                    verticalSpacing: 1.2,
                    
                  ),
                ),
                VerticalSpacing(1.75), // gap: 40px
                // Main Card with Image
                Exercise2MainCardWidget(
                  key: controller.mainCardKey,
                  imageAsset: ffWebsite,
                  title: 'Form&Fun Landing Page',
                  subtitle: 'HTML',
                  buttonText: 'View',
                  onButtonPressed: _openFormAndFunWebsite,
                ),
                VerticalSpacing(1.5),
                // Long Description Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w), // 8px
                  child: TextWidget(
                    _getLongDescription(),
                    fontSize: context.font_20sp,
                    fontWeight: regularWeight,
                    textColor: darkColor,
                    verticalSpacing: 1.2,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
                // Extra space at bottom for footer
                SizedBox(height: footerHeight + bottomPadding + 20),
              ],
            ),
          ),
          // Blur overlay - esconde quando chega no bottom do scroll
          Obx(() => AnimatedOpacity(
            opacity: controller.isAtBottom ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Exercise2BlurOverlayWidget(height: 150),
            ),
          )),
          // Footer card animado - slide up/down baseado no scroll
          Obx(() {
            final progress = controller.footerProgress;
            // Footer começa abaixo da tela (bottom negativo) e sobe para bottomPadding
            final footerBottomPosition = bottomPadding - ((1 - progress) * (footerHeight + bottomPadding + 30));

            return Positioned(
              left: 4.w,
              right: 4.w,
              bottom: footerBottomPosition,
              child: Exercise2FooterCardWidget(
                logoAsset: ffLogo,
                title: 'Form&Fun',
                subtitle: 'formandfun.co',
                onTap: _openFormAndFunWebsite,
              ),
            );
          }),
        ],
      ),
      ),
    );
  }

  Future<void> _openFormAndFunWebsite() async {
    final url = Uri.parse('https://www.formandfun.co');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  String _getLongDescription() {
    return '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras at odio quam. Etiam sed lorem id ligula egestas ornare non ac mauris. Proin non sagittis justo. Sed id viverra est. Integer enim sem, scelerisque vitae tristique sit amet, ullamcorper vel arcu. Nullam mollis posuere turpis, ac dignissim quam sodales eget. Aenean congue fringilla pretium. Morbi volutpat fringilla luctus. Donec et ligula sit amet mauris sodales tristique a ac quam. Donec vel libero a libero laoreet eleifend a ut nisi. Donec ut sem in orci gravida mattis eget ut nibh. Ut faucibus sollicitudin magna, ac sollicitudin ex tristique at.

Pellentesque vehicula nisl et augue commodo, id bibendum urna tristique. Morbi in malesuada libero. Nullam rhoncus ex quis urna fringilla euismod vel imperdiet justo. Quisque condimentum cursus facilisis. Donec ex sem, efficitur sed sagittis ac, accumsan mattis libero. Pellentesque vulputate eget odio vel convallis. Proin malesuada pulvinar felis, sed lobortis sem porttitor ac. Vivamus molestie vehicula orci, efficitur rutrum nulla semper ac. Phasellus ut ligula tortor. In augue est, elementum a sodales eu, sodales id lectus. Sed ac luctus leo. Nullam a nulla pellentesque, scelerisque dolor in, mattis turpis.''';
  }
}
