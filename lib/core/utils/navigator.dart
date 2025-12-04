import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_adapter/i_custom_instance_manager.dart';
import 'package:formfun_flutter_test/core/infrastructure/injections/instance_manager_config.dart';

abstract class MStatefulWidget extends StatefulWidget {
  const MStatefulWidget({super.key});
}

abstract class MState<T extends StatefulWidget, S extends Object> extends State<T> {
  String? identifier;
  late S controller;
  String? instanceNameTag;
  bool deleteController = true;

  @override
  void initState() {
    super.initState();
    if (identifier != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onAppearing();
      });
    }
  }

  void registerController(S controllerInstance, {String? tag}) {
    if (S != Null) {
      if (!instanceManager.exists<S>(tag: tag)) {
        controller = context.registerController<S>(controllerInstance, tag: tag);
        instanceNameTag = tag;
      } else {
        controller = instanceManager.get<S>(tag: tag);
        context.assignContext<S>(tag: tag);
      }
    }
  }

  @override
  void dispose() {
    if (S != Null && deleteController) {
      instanceManager.delete<S>(tag: instanceNameTag);
    }
    super.dispose();
  }

  @protected
  @mustCallSuper
  void onAppearing() {
    log('onAppearing');
  }
}
