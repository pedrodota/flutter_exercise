import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/core/shared/presentation/controller/base_controller.dart';

class Exercise1Controller extends BaseController {
  late RxDouble _percentage;
  Timer? _timer;

  double get percentage => _percentage.value;
  set percentage(double value) => _percentage.value = value;

  bool get isComplete => percentage >= 100;

  @override
  void start() {
    _percentage = RxDouble(0);
    // Não inicia timer em modo de teste
    if (!kIsTest) {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    }
  }

  void _onTick(Timer timer) {
    if (isComplete) {
      timer.cancel();
      return;
    }
    percentage += 10;
  }

  void loadData() {
    _timer?.cancel();
    percentage = 0;
    if (!kIsTest) {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

/// Flag para indicar se está em modo de teste
bool kIsTest = false;
