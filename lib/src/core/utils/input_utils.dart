import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
class InputUtils {
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
  }

  static bool get isMouseConnected =>
      RendererBinding.instance.mouseTracker.mouseIsConnected;

  static void unFocus() {
    primaryFocus?.unfocus();
  }
}

class FormValidatorsHelper {
  String formName;
  int minlength;
  int maxLength;
  bool isRequired;

  FormValidatorsHelper({
    required this.formName,
    this.minlength = 0,
    this.maxLength = 0,
    this.isRequired = false,
  });

  String? validateError(String? value) {
    if (isRequired == true && true == value?.isEmpty) {
      return '$formName is required!';
    }
    if (minlength != 0 && value.toString().length < minlength) {
      return '$formName is minimum of $minlength characters';
    }
    if (maxLength != 0 && value.toString().length > maxLength) {
      return '$formName is maximum of $maxLength characters';
    }

    return null;
  }
}
