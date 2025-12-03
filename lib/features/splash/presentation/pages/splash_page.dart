import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/app/routes.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.exercise1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: appBackground,
    );
  }
}
