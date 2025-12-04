import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:formfun_flutter_test/core/shared/presentation/controller/base_controller.dart';

class Exercise2Controller extends BaseController {
  late ScrollController scrollController;
  late RxDouble _footerProgress;
  late RxBool _isAtBottom;

  final GlobalKey mainCardKey = GlobalKey();

  double get footerProgress => _footerProgress.value;
  set footerProgress(double value) => _footerProgress.value = value;

  /// true quando scroll está no bottom
  bool get isAtBottom => _isAtBottom.value;
  set isAtBottom(bool value) => _isAtBottom.value = value;

  @override
  void start() {
    _footerProgress = RxDouble(0.0);
    _isAtBottom = RxBool(false);
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _updateFooterProgress();
    _updateBottomStatus();
  }

  void _updateFooterProgress() {
    final cardContext = mainCardKey.currentContext;
    if (cardContext == null) return;

    final RenderBox? renderBox = cardContext.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    // Posição do card relativa à tela
    final cardPosition = renderBox.localToGlobal(Offset.zero);
    final cardHeight = renderBox.size.height;
    final cardBottom = cardPosition.dy + cardHeight;

    // Footer começa a aparecer quando o bottom do card chega a 30% da altura do card
    // (ou seja, só 30% do card ainda está visível)
    final threshold = cardHeight * 0.3;

    if (cardBottom >= threshold) {
      // Card ainda bem visível - footer escondido
      footerProgress = 0.0;
    } else if (cardBottom <= 0) {
      // Card sumiu - footer 100%
      footerProgress = 1.0;
    } else {
      // Animação em progresso: cardBottom vai de threshold até 0
      final progress = 1.0 - (cardBottom / threshold);
      footerProgress = progress.clamp(0.0, 1.0);
    }
  }

  void _updateBottomStatus() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;

    // Considera "no bottom" quando está a 10px ou menos do final
    isAtBottom = (maxScroll - currentScroll) <= 10;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
