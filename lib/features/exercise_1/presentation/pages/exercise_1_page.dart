import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/core/shared/presentation/backgrounds/base_background.dart';
import 'package:formfun_flutter_test/core/utils/navigator.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/controller/exercise_1_controller.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/widgets/exercise_1_card_widget.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/pages/exercise_2_page.dart';

class Exercise1Page extends StatefulWidget {
  const Exercise1Page({super.key});

  @override
  State<Exercise1Page> createState() => _Exercise1PageState();
}

class _Exercise1PageState extends MState<Exercise1Page, Exercise1Controller> {
  @override
  void initState() {
    registerController(Exercise1Controller());
    super.initState();

    // Configura callback para navegar ao Exercise 2 quando completar
    controller.onComplete = _navigateToExercise2;
  }

  void _navigateToExercise2() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Exercise2Page(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Center(
        child: Obx(
          () => TweenAnimationBuilder<double>(
            tween: Tween(end: controller.percentage),
            duration: const Duration(milliseconds: 500),
            builder: (context, animatedValue, child) => Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: Exercise1CardWidget(
                title: 'loading_file'.tr,
                subtitle: controller.elapsedTimeFormatted,
                percentage: animatedValue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
