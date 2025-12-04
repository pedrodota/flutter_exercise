import 'package:flutter/widgets.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';

class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing(this.spacing, {super.key});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: spacing.w);
  }
}
