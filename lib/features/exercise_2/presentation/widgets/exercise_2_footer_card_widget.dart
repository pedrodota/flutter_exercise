import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/horizontal_spacing_widget.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/text_widget.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';

class Exercise2FooterCardWidget extends StatelessWidget {
  final String logoAsset;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const Exercise2FooterCardWidget({
    super.key,
    required this.logoAsset,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPressed = false.obs;

    return Semantics(
      button: true,
      label: 'Open $title website at $subtitle',
      child: GestureDetector(
        onTapDown: (_) => isPressed.value = true,
        onTapUp: (_) {
          isPressed.value = false;
          HapticFeedback.lightImpact();
          onTap?.call();
        },
        onTapCancel: () => isPressed.value = false,
        child: Obx(() => AnimatedScale(
          scale: isPressed.value ? 0.98 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: 92.3.w,
            height: 68,
            decoration: BoxDecoration(
              color: context.footerColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const HorizontalSpacing(2.5),
                // Logo icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.isDark ? white.withValues(alpha: 0.1) : black.withValues(alpha: 0.1),
                      width: 0.5,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      logoAsset,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const HorizontalSpacing(4),
                // Title section
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title,
                      fontSize: context.font_15sp,
                      fontWeight: extraBoldWeight,
                      textColor: context.textPrimaryColor,
                    ),
                    TextWidget(
                      subtitle,
                      fontSize: context.font_13sp,
                      fontWeight: regularWeight,
                      textColor: context.footerSubtitle,
                      letterSpacing: 0.02 * context.font_13sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
