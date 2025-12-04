import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/app/app.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_adapter/instance_manager.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  instanceManager = GetItInstanceManager();
  runApp(const App());
}
