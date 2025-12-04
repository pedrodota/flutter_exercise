import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_adapter/i_custom_instance_manager.dart';

class GetItInstanceManager implements ICustomInstanceManager {
  late final GetIt _getIt;

  GetItInstanceManager() {
    _getIt = GetIt.instance;
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() func) {
    _getIt.registerLazySingleton<T>(func);
  }

  @override
  void registerSingleton<T extends Object>(T instance, {String? instanceName}) {
    _getIt.registerSingleton<T>(instance, instanceName: instanceName);
  }

  @override
  T get<T extends Object>({String? tag}) {
    return _getIt.get<T>(instanceName: tag);
  }

  @override
  bool exists<T extends Object>({String? tag}) {
    if (tag != null) {
      try {
        return getByString<T>(tag) != null;
      } catch (e) {
        return false;
      }
    }
    return _getIt.isRegistered<T>(instanceName: tag);
  }

  T? getByString<T extends Object>(String instanceName) {
    return _getIt.get<T>(instanceName: instanceName);
  }

  @override
  void reset() {
    _getIt.reset();
  }

  @override
  void delete<T extends Object>({String? tag}) {
    if (exists<T>(tag: tag)) {
      _getIt.unregister<T>(instanceName: tag);
    }
  }

  void deleteByString<T extends Object>(String instanceName) {
    _getIt.unregister<T>(instanceName: instanceName);
  }

  void removeControllersFromRoute(String? routeName) {
    if (routeName == null) return;
    try {
      final controllerName = '${routeName.split('Page').first}Controller';
      deleteByString(controllerName);
    } catch (e) {
      log('Erro ao remover controller da rota: $routeName: $e');
    }
  }
}
