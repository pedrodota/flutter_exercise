import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';

class Exercise2BlurOverlayWidget extends StatelessWidget {
  final double height;

  const Exercise2BlurOverlayWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final bgColor = context.backgroundColor;

    return IgnorePointer(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.75, sigmaY: 0.75),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.4, 0.75, 1.0],
                colors: [
                  bgColor.withValues(alpha: 0),
                  bgColor.withValues(alpha: 0.3),
                  bgColor.withValues(alpha: 0.8),
                  bgColor,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
