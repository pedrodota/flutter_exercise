import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';

class BaseBackground extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool useSafeAreaOnTop;

  const BaseBackground({
    super.key,
    required this.child,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.useSafeAreaOnTop = true,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? masterColorA,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        top: useSafeAreaOnTop,
        child: child,
      ),
    );
  }
}
