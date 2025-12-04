import 'package:flutter/widgets.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing(this.spacing, {super.key});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: spacing.h);
  }
}
