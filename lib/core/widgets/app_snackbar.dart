import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../global_keys.dart';

enum AppMessageType { good, bad, warning, info }


class AppSnackBar {
  AppSnackBar._internal();

  static Future<void> _show({
    required String message,
    required AppMessageType type,
    Duration? duration,
  }) async {
    try {
      ToastificationType toastType;

      switch (type) {
        case AppMessageType.good:
          toastType = ToastificationType.success;
          break;
        case AppMessageType.bad:
          toastType = ToastificationType.error;
          break;
        case AppMessageType.warning:
          toastType = ToastificationType.warning;
          break;
        case AppMessageType.info:
          toastType = ToastificationType.info;
          break;
      }

      toastification.show(
        overlayState: globalNavigatorKey.currentState?.overlay,
        type: toastType,
        title: Text(message, maxLines: 10),
        backgroundColor: Colors.white,
        boxShadow: highModeShadow,
        alignment: Alignment.topCenter,
        autoCloseDuration: duration ?? const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 500),
        showProgressBar: false,
      );
    } catch (e) {
      print('Error showing snackbar: $e');
    }
  }

  static void bad(String message) {
    AppSnackBar._show(message: message, type: AppMessageType.bad);
  }

  static void good(String message) {
    AppSnackBar._show(message: message, type: AppMessageType.good);
  }

  static void warning(String message) {
    AppSnackBar._show(message: message, type: AppMessageType.warning);
  }

  static void info(String message) {
    AppSnackBar._show(message: message, type: AppMessageType.info);
  }
}
