import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? verticalSpacing;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final int? maxLines;
  final String? fontFamily;

  const TextWidget(
    this.text, {
    super.key,
    this.textColor,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.overflow,
    this.letterSpacing,
    this.maxLines,
    this.verticalSpacing,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle(
        decoration: textDecoration,
        letterSpacing: letterSpacing,
        height: verticalSpacing,
        color: textColor ?? Theme.of(context).textTheme.bodyMedium?.color ?? textStylePadrao.color,
        fontSize: fontSize ?? Theme.of(context).textTheme.bodyMedium?.fontSize ?? textStylePadrao.fontSize,
        fontWeight: fontWeight ?? Theme.of(context).textTheme.bodyMedium?.fontWeight ?? textStylePadrao.fontWeight,
        fontFamily: fontFamily ?? fontAktivGrotesk,
      ),
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }

  static TextStyle textStylePadrao = TextStyle(
    color: darkColor,
    fontSize: 3.6.w,
    fontWeight: FontWeight.normal,
  );
}
