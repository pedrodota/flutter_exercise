import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/theme/app_colors.dart';

class Exercise1Page extends StatelessWidget {
  const Exercise1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: masterColorA,
      body: Center(
        child: Text('Exercise 1 Page - TODO'),
      ),
    );
  }
}
