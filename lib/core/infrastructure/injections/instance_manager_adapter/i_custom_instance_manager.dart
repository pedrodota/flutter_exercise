import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_config.dart';

abstract class ICustomInstanceManager {
  void registerLazySingleton<T extends Object>(T Function() func);

  void registerSingleton<T extends Object>(T instance, {String? instanceName});

  T get<T extends Object>({String? tag});

  bool exists<T extends Object>({String? tag});

  void reset();

  void delete<T extends Object>({String? tag});
}

extension ICustomInstanceManagerExtension on BuildContext {
  T registerController<T extends Object>(T controller, {String? tag}) {
    if (!instanceManager.exists<T>(tag: tag)) {
      instanceManager.registerSingleton<T>(controller, instanceName: tag);
    }
    assignContext<T>(tag: tag);
    final instance = instanceManager.get<T>(tag: tag);
    return instance;
  }

  void assignContext<T extends Object>({String? tag}) {
    final instance = instanceManager.get<T>(tag: tag);
    try {
      (instance as dynamic).context = this;
    } catch (e) {
      log('A variável não existe nesta instância da classe.');
    }
  }
}
