import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formfun_flutter_test/features/exercise_2/presentation/controller/exercise_2_controller.dart';

void main() {
  group('Exercise2Controller', () {
    late Exercise2Controller controller;

    setUp(() {
      controller = Exercise2Controller();
      controller.start();
    });

    tearDown(() {
      try {
        controller.onClose();
      } catch (_) {
        // Já foi disposed
      }
    });

    group('initialization', () {
      test('should start with footerProgress at 0', () {
        expect(controller.footerProgress, 0.0);
      });

      test('should start with isAtBottom as false', () {
        expect(controller.isAtBottom, false);
      });

      test('should have a scroll controller', () {
        expect(controller.scrollController, isA<ScrollController>());
      });

      test('should have a main card key', () {
        expect(controller.mainCardKey, isA<GlobalKey>());
      });
    });

    group('footerProgress', () {
      test('should update footerProgress correctly', () {
        controller.footerProgress = 0.5;
        expect(controller.footerProgress, 0.5);
      });

      test('should accept 0.0 value', () {
        controller.footerProgress = 0.0;
        expect(controller.footerProgress, 0.0);
      });

      test('should accept 1.0 value', () {
        controller.footerProgress = 1.0;
        expect(controller.footerProgress, 1.0);
      });
    });

    group('isAtBottom', () {
      test('should update isAtBottom correctly', () {
        controller.isAtBottom = true;
        expect(controller.isAtBottom, true);
      });

      test('should toggle isAtBottom', () {
        controller.isAtBottom = true;
        expect(controller.isAtBottom, true);

        controller.isAtBottom = false;
        expect(controller.isAtBottom, false);
      });
    });

    group('scroll controller lifecycle', () {
      test('should have scroll controller before close', () {
        expect(controller.scrollController, isNotNull);
        expect(controller.scrollController, isA<ScrollController>());
      });
    });
  });
}
