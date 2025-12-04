import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Container(
      width: 92.w, 
      padding: EdgeInsets.all(1.h), 
      decoration: BoxDecoration(color: cardBackground, borderRadius: BorderRadius.circular(32)),
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
                      SvgPicture.asset(tagsIcon, width: 4.h, height: 4.h),
                      HorizontalSpacing(2.75),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(title, fontSize: context.font_14sp, fontWeight: semiBoldWeight, textColor: darkColor, maxLines: 1),
                            TextWidget(subtitle, fontSize: context.font_12sp, fontWeight: regularWeight, textColor: taglineColor, maxLines: 1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const HorizontalSpacing(2),
                // Button
                _buildButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h), 
        decoration: BoxDecoration(color: darkColor, borderRadius: BorderRadius.circular(9999)),
        child: TextWidget(buttonText, fontSize: context.font_16sp, fontWeight: mediumWeight, textColor: lightColor),
      ),
    );
  }
}
