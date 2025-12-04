import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:formfun_flutter_test/core/utils/measurements.dart';
import 'package:formfun_flutter_test/core/theme/app_theme.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_adapter/instance_manager.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_config.dart';
import 'package:formfun_flutter_test/features/exercise_1/presentation/controller/exercise_1_controller.dart';

class Device {
  late final String name;
  late final Size size;

  bool get isTablet => name.toLowerCase().contains('tablet');
  String get deviceName => name.replaceAll(' ', '_');

  Device(this.name, this.size);
}

List<Device> devices = [
  Device('iPhone_6', const Size(375, 667)),
  Device('iPhone_16_Pro', const Size(402, 874)),
  Device('iPhone_16_Pro_Max', const Size(440, 956)),
  Device('Tablet', const Size(1024, 768)),
  Device('Tablet_vertical', const Size(768, 1024)),
];

class BasePageTestWrapper extends StatelessWidget {
  final Widget page;
  final void Function()? setupFunction;
  const BasePageTestWrapper(this.page, this.setupFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: _BasePageWithMeasurements(page, setupFunction),
    );
  }
}

class _BasePageWithMeasurements extends StatelessWidget {
  final Widget page;
  final void Function()? setupFunction;
  const _BasePageWithMeasurements(this.page, this.setupFunction);

  @override
  Widget build(BuildContext context) {
    AppMeasurements.setAppMeasurements(context);
    setupFunction?.call();
    return page;
  }
}

String _getGoldensDirectory(String testName) {
  return 'test/golden/$testName/goldens';
}

Future<void> _combineImages(
    List<String> imageFiles, String testName, String outputFileName) async {
  try {
    log('Iniciando combinacao de imagens...');

    final goldensDir = _getGoldensDirectory(testName);

    for (final imageFile in imageFiles) {
      final file = File('$goldensDir/$imageFile');
      if (!await file.exists()) {
        throw Exception('Imagem nao encontrada: $goldensDir/$imageFile');
      }
      log('Encontrada: $imageFile');
    }

    final args = [
      ...imageFiles.map((f) => '$goldensDir/$f'),
      '+append',
      '$goldensDir/$outputFileName'
    ];

    ProcessResult result;
    if (Platform.isWindows) {
      try {
        result = await Process.run('magick', args);
      } catch (e) {
        result = await Process.run('convert', args);
      }
    } else {
      result = await Process.run('convert', args);
    }

    if (result.exitCode == 0) {
      log('Imagens combinadas com sucesso!');
    } else {
      log('Erro ao combinar imagens: ${result.stderr}');
      await _createSimpleCombinedImage(imageFiles, testName, outputFileName);
    }
  } catch (e) {
    log('Erro na combinacao: $e');
    await _createSimpleCombinedImage(imageFiles, testName, outputFileName);
  }
}

Future<void> _createSimpleCombinedImage(
    List<String> imageFiles, String testName, String outputFileName) async {
  try {
    final goldensDir = _getGoldensDirectory(testName);

    final phones = <Device>[];
    final tablets = <Device>[];
    final phoneImages = <String>[];
    final tabletImages = <String>[];

    for (int i = 0; i < devices.length; i++) {
      final device = devices[i];
      final image = imageFiles[i];
      if (device.isTablet) {
        tablets.add(device);
        tabletImages.add(image);
      } else {
        phones.add(device);
        phoneImages.add(image);
      }
    }

    final htmlContent = '''
<!DOCTYPE html>
<html>
<head>
    <title>$testName - All Devices</title>
    <style>
        body {
            margin: 0;
            padding: 20px;
            background: #f0f0f0;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            flex-direction: column;
            gap: 40px;
            align-items: center;
        }
        .row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }
        .device {
            text-align: center;
        }
        .device img {
            border: 2px solid #333;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            max-width: 100%;
            height: auto;
        }
        .device h3 {
            margin: 10px 0 5px 0;
            color: #333;
        }
        .title {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <h1 class="title">$testName - Golden Tests - All Devices</h1>
    <div class="container">
        <div class="row phones">
            ${phones.asMap().entries.map((entry) => '''
            <div class="device">
                <h3>${entry.value.deviceName} (${entry.value.size.width}x${entry.value.size.height})</h3>
                <img src="${phoneImages[entry.key]}" alt="${entry.value.deviceName}">
            </div>
            ''').join('')}
        </div>
        <div class="row tablets">
            ${tablets.asMap().entries.map((entry) => '''
            <div class="device">
                <h3>${entry.value.deviceName} (${entry.value.size.width}x${entry.value.size.height})</h3>
                <img src="${tabletImages[entry.key]}" alt="${entry.value.deviceName}">
            </div>
            ''').join('')}
        </div>
    </div>
</body>
</html>
''';

    final htmlFile = File('$goldensDir/${testName}_combined.html');
    await htmlFile.writeAsString(htmlContent);

    log('Arquivo HTML criado: $goldensDir/${testName}_combined.html');
    await _openGeneratedImage('${testName}_combined.html', testName);
  } catch (e) {
    log('Erro ao criar arquivo HTML: $e');
  }
}

Future<void> _openGeneratedImage(String fileName, String testName) async {
  final goldensDir = _getGoldensDirectory(testName);
  final goldenPath = '$goldensDir/$fileName';

  try {
    final file = File(goldenPath);

    if (await file.exists()) {
      log('Tentando abrir: $goldenPath');
      if (Platform.isWindows) {
        await Process.run('start', [goldenPath], runInShell: true);
      } else if (Platform.isMacOS) {
        await Process.run('open', [goldenPath]);
      } else if (Platform.isLinux) {
        await Process.run('xdg-open', [goldenPath]);
      }
      log('Imagem aberta com sucesso!');
    } else {
      log('Arquivo nao encontrado: $goldenPath');
    }
  } catch (e) {
    log('Erro ao abrir imagem: $e');
    log('Voce pode encontrar a imagem em: $goldenPath');
  }
}

void _clearGoldensDirectory(String testName) {
  final goldensDir = Directory(_getGoldensDirectory(testName));
  if (goldensDir.existsSync()) {
    for (var file in goldensDir.listSync()) {
      if (file is File &&
          (file.path.endsWith('.png') || file.path.endsWith('.html'))) {
        file.deleteSync();
      }
    }
  } else {
    goldensDir.createSync(recursive: true);
  }
}

void runBaseGoldenTests({
  required Widget page,
  required String testName,
  void Function()? setupFunction,
}) {
  group(testName, () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await loadAppFonts();

      // Força a criação de golden files
      autoUpdateGoldenFiles = true;

      // Desabilita Timer em controllers durante testes
      kIsTest = true;

      // Inicializa o instance manager
      instanceManager = GetItInstanceManager();

      _clearGoldensDirectory(testName);

      log('Configuracao inicial concluida');
      log('Iniciando testes: $testName');
      if (setupFunction != null) {
        log('Setup customizado sera executado em cada teste...');
      }
      log('');
    });

    tearDown(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      instanceManager.reset();
    });

    tearDownAll(() {
      instanceManager.reset();
    });

    for (var device in devices) {
      testWidgets('$testName - ${device.deviceName}', (tester) async {
        tester.view.physicalSize = device.size;
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          BasePageTestWrapper(page, setupFunction),
        );
        await tester.pump(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/${testName}_${device.deviceName}.png'),
        );

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    }

    test('Combine Individual Images into One', () async {
      log('\nCombinando as ${devices.length} imagens individuais em uma unica imagem...');

      await _combineImages(
        devices.map((device) => '${testName}_${device.deviceName}.png').toList(),
        testName,
        '${testName}_all_devices_combined.png',
      );

      log('Imagem combinada criada com sucesso!');
      log('Arquivo: ${testName}_all_devices_combined.png');
      await _openGeneratedImage('${testName}_all_devices_combined.png', testName);
    });
  });
}
