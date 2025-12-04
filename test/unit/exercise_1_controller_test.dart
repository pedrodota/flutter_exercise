import 'package:flutter_test/flutter_test.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/controller/exercise_1_controller.dart';

void main() {
  late Exercise1Controller controller;

  setUp(() {
    kIsTest = true;
    controller = Exercise1Controller();
    controller.start();
  });

  tearDown(() {
    controller.onClose();
  });

  group('Exercise1Controller', () {
    group('initialization', () {
      test('should start with 0% percentage', () {
        expect(controller.percentage, 0.0);
      });

      test('should start with 0 elapsed seconds', () {
        expect(controller.elapsedSeconds, 0);
      });

      test('should not be complete initially', () {
        expect(controller.isComplete, false);
      });
    });

    group('percentage', () {
      test('should update percentage correctly', () {
        controller.percentage = 50;
        expect(controller.percentage, 50.0);
      });

      test('should be complete when percentage reaches 100', () {
        controller.percentage = 100;
        expect(controller.isComplete, true);
      });

      test('should not be complete when percentage is below 100', () {
        controller.percentage = 99;
        expect(controller.isComplete, false);
      });
    });

    group('elapsedTimeFormatted', () {
      test('should return "0s" when elapsed seconds is 0', () {
        controller.elapsedSeconds = 0;
        expect(controller.elapsedTimeFormatted, '0s');
      });

      test('should return seconds only when less than 60', () {
        controller.elapsedSeconds = 45;
        expect(controller.elapsedTimeFormatted, '45s');
      });

      test('should return minutes and seconds when 60 or more', () {
        controller.elapsedSeconds = 90;
        expect(controller.elapsedTimeFormatted, '1m 30s');
      });

      test('should return correct format for exact minutes', () {
        controller.elapsedSeconds = 120;
        expect(controller.elapsedTimeFormatted, '2m 0s');
      });
    });

    group('loadData', () {
      test('should reset percentage to 0', () {
        controller.percentage = 50;
        controller.loadData();
        expect(controller.percentage, 0.0);
      });

      test('should reset elapsed seconds to 0', () {
        controller.elapsedSeconds = 30;
        controller.loadData();
        expect(controller.elapsedSeconds, 0);
      });
    });

    group('onComplete callback', () {
      test('should allow setting onComplete callback', () {
        var wasCalled = false;
        controller.onComplete = () => wasCalled = true;
        controller.onComplete?.call();
        expect(wasCalled, true);
      });
    });
  });
}
