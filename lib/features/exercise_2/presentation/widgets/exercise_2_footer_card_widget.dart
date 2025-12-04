import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 92.3.w, // 360/390
      height: 68,
      decoration: BoxDecoration(
        color: footerBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          SizedBox(width: 2.5.w), // 10px padding
          // Logo icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: white,
              shape: BoxShape.circle,
              border: Border.all(
                color: black.withValues(alpha: 0.1),
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
          SizedBox(width: 4.w), // gap between logo and title ~15px
          // Title section
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title,
                fontSize: context.font_15sp,
                fontWeight: extraBoldWeight,
                textColor: black,
              ),
              TextWidget(
                subtitle,
                fontSize: context.font_13sp,
                fontWeight: regularWeight,
                textColor: footerSubtitleColor,
                letterSpacing: 0.02 * context.font_13sp,
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
