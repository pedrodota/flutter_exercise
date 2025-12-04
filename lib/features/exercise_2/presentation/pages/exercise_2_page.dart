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
          'press_back_again'.tr,
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
                    'heres_your_landing_page'.tr,
                    fontSize: context.font_20sp,
                    fontWeight: regularWeight,
                    textColor: context.textPrimaryColor,
                    verticalSpacing: 1.2,
                  ),
                ),
                const VerticalSpacing(1.75), // gap: 40px
                // Main Card with Image
                Exercise2MainCardWidget(
                  key: controller.mainCardKey,
                  imageAsset: ffWebsite,
                  title: 'landing_page_title'.tr,
                  subtitle: 'landing_page_subtitle'.tr,
                  buttonText: 'view_button'.tr,
                  onButtonPressed: _openFormAndFunWebsite,
                ),
                const VerticalSpacing(1.5),
                // Long Description Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w), // 8px
                  child: TextWidget(
                    'long_description'.tr,
                    fontSize: context.font_20sp,
                    fontWeight: regularWeight,
                    textColor: context.textPrimaryColor,
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
                title: 'footer_title'.tr,
                subtitle: 'footer_subtitle'.tr,
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
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackbar('could_not_open_website'.tr);
      }
    } catch (e) {
      _showErrorSnackbar('error_opening_link'.tr);
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget(
          message,
          fontSize: context.font_14sp,
          fontWeight: mediumWeight,
          textColor: lightColor,
        ),
        backgroundColor: darkColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      ),
    );
  }
}
