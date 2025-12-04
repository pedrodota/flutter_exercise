import 'package:flutter/widgets.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing(this.spacing, {super.key});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (spacing * 0.01),
    );
  }
}
