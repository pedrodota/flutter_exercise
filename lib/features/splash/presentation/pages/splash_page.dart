import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: masterColorA,
      body: Center(
        child: Text('Splash Page - TODO'),
      ),
    );
  }
}
