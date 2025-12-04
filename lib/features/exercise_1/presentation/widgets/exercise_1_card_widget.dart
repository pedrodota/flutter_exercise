import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';
import 'package:formfun_flutter_test/core/theme/app_typography.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/text_widget.dart';
import 'package:formfun_flutter_test/core/shared/presentation/widgets/vertical_spacing_widget.dart';
import 'package:formfun_flutter_test/core/utils/assets.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';

class Exercise1CardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double percentage;
  final bool animateLottie;

  const Exercise1CardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.percentage,
    this.animateLottie = true,
  });

  @override
  Widget build(BuildContext context) {
    final double radius = 32;

    return Container(
      width: 92.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFFE8E8E3), width: 1),
        boxShadow: [ 
          BoxShadow(
            color: const Color(0xFFE5CAFE),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFF7E52F4).withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: CustomPaint(
        foregroundPainter: CardBorderPainter(
          percentage: percentage,
          borderRadius: radius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              searchingAnimation,
              width: 20.5.w,
              height: 20.5.w,
              fit: BoxFit.contain,
              animate: animateLottie,
            ),
            const VerticalSpacing(2),
            TextWidget(
              title ,
              fontSize: context.font_14sp,
              fontWeight: semiBoldWeight,
              textColor: darkColor,
              maxLines: 2,
              verticalSpacing: 18 / 14,
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(1.75),
            TextWidget(
              subtitle,
              fontSize: context.font_12sp,
              fontWeight: regularWeight,
              textColor: taglineColor,
              verticalSpacing: 15 / 12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CardBorderPainter extends CustomPainter {
  final double percentage;
  final double borderRadius;

  CardBorderPainter({
    required this.percentage,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (percentage <= 0) return;

    const strokeWidth = 1.0;
    final halfStroke = strokeWidth / 2;
    final width = size.width + strokeWidth;
    final height = size.height + strokeWidth;
    final radius = borderRadius;
    final centerX = width / 2;

    // Constrói o path começando do centro do topo, indo no sentido horário
    final path = Path();
    path.moveTo(centerX - halfStroke, -halfStroke);

    // Centro-topo -> canto superior direito
    path.lineTo(width - radius - halfStroke, -halfStroke);
    path.arcToPoint(
      Offset(width - halfStroke, radius - halfStroke),
      radius: Radius.circular(radius),
    );

    // Lado direito -> canto inferior direito
    path.lineTo(width - halfStroke, height - radius - halfStroke);
    path.arcToPoint(
      Offset(width - radius - halfStroke, height - halfStroke),
      radius: Radius.circular(radius),
    );

    // Lado inferior -> canto inferior esquerdo
    path.lineTo(radius - halfStroke, height - halfStroke);
    path.arcToPoint(
      Offset(-halfStroke, height - radius - halfStroke),
      radius: Radius.circular(radius),
    );

    // Lado esquerdo -> canto superior esquerdo
    path.lineTo(-halfStroke, radius - halfStroke);
    path.arcToPoint(
      Offset(radius - halfStroke, -halfStroke),
      radius: Radius.circular(radius),
    );

    // Volta ao centro do topo
    path.lineTo(centerX - halfStroke, -halfStroke);

    final pathMetrics = path.computeMetrics().first;
    final totalLength = pathMetrics.length;
    final drawLength = totalLength * (percentage / 100);

    final extractPath = pathMetrics.extractPath(0, drawLength);

    final paint = Paint()
      ..color = const Color(0xFF9A79F2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant CardBorderPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}
