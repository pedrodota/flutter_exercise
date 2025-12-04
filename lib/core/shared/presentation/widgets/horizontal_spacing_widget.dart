import 'package:flutter/widgets.dart';

class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing(this.spacing, {super.key});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (spacing * 0.01),
    );
  }
}
