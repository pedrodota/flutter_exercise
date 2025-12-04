import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/horizontal_spacing_widget.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/text_widget.dart';
import 'package:formfun_flutter_test/core/utils/assets.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';

class Exercise2MainCardWidget extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const Exercise2MainCardWidget({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Landing page card. $title, $subtitle',
      child: Container(
        width: 92.w,
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container - 16:9 aspect ratio
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(imageAsset, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(2.h, 3.h, 2.h, 2.h),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          tagsIcon,
                          width: 4.h,
                          height: 4.h,
                          colorFilter: context.isDark
                              ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                              : null,
                        ),
                        const HorizontalSpacing(2.75),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWidget(title, fontSize: context.font_14sp, fontWeight: semiBoldWeight, textColor: context.textPrimaryColor, maxLines: 1),
                              TextWidget(subtitle, fontSize: context.font_12sp, fontWeight: regularWeight, textColor: context.textSecondaryColor, maxLines: 1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HorizontalSpacing(2),
                  // Button with scale animation
                  _AnimatedButton(
                    text: buttonText,
                    onPressed: onButtonPressed,
                    semanticLabel: 'View $title',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Botão animado usando GetX para gerenciamento de estado
class _AnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final String semanticLabel;

  const _AnimatedButton({
    required this.text,
    required this.semanticLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isPressed = false.obs;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        onTapDown: (_) => isPressed.value = true,
        onTapUp: (_) {
          isPressed.value = false;
          HapticFeedback.lightImpact();
          onPressed?.call();
        },
        onTapCancel: () => isPressed.value = false,
        child: Obx(() => AnimatedScale(
          scale: isPressed.value ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
            decoration: BoxDecoration(color: context.buttonColor, borderRadius: BorderRadius.circular(9999)),
            child: TextWidget(text, fontSize: context.font_16sp, fontWeight: mediumWeight, textColor: context.textOnButtonColor),
          ),
        )),
      ),
    );
  }
}
