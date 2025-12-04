import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/core/shared/presentation/controller/base_controller.dart';

class Exercise1Controller extends BaseController {
  late RxDouble _percentage;
  late RxInt _elapsedSeconds;
  Timer? _timer;
  DateTime? _startTime;

  /// Callback para navegar quando completar
  VoidCallback? onComplete;

  /// Tempo total em segundos (10 segundos para 100%)
  static const int totalDurationSeconds = 10;

  double get percentage => _percentage.value;
  set percentage(double value) => _percentage.value = value;

  int get elapsedSeconds => _elapsedSeconds.value;
  set elapsedSeconds(int value) => _elapsedSeconds.value = value;

  bool get isComplete => percentage >= 100;

  /// Retorna o tempo decorrido formatado (ex: "1m 30s", "45s", "0s")
  String get elapsedTimeFormatted {
    if (elapsedSeconds <= 0) return '0s';

    final minutes = elapsedSeconds ~/ 60;
    final seconds = elapsedSeconds % 60;

    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  @override
  void start() {
    _percentage = RxDouble(0);
    _elapsedSeconds = RxInt(0);
    _startTime = DateTime.now();

    // Não inicia timer em modo de teste
    if (!kIsTest) {
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    }
  }

  void _onTick(Timer timer) {
    if (isComplete) {
      timer.cancel();
      // Espera 1 segundo e navega para Exercise 2
      Future.delayed(const Duration(seconds: 1), () {
        onComplete?.call();
      });
      return;
    }

    // Atualiza o tempo decorrido baseado na diferença com startTime
    if (_startTime != null) {
      elapsedSeconds = DateTime.now().difference(_startTime!).inSeconds;
    }

    // Incrementa 10% por segundo
    percentage += 10;
  }

  void loadData() {
    _timer?.cancel();
    percentage = 0;
    elapsedSeconds = 0;
    _startTime = DateTime.now();

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
