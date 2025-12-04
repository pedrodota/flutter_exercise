import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  late RxBool _isLoading;
  late final GlobalKey<FormState> _formKey;
  late BuildContext context;

  BaseController() {
    _isLoading = false.obs;
    _formKey = GlobalKey<FormState>();
    start();
  }

  void start();

  // Getters
  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> get formKey => _formKey;
  bool formValidation() => formKey.currentState?.validate() ?? true;

  // Setters
  set isLoading(bool value) => _isLoading.value = value;
}
