import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:xbridge/common/constants/app_colors.dart';

/// Extension on BuildContext to show success and error messages using Flushbar.
extension XBuildContext on BuildContext {
  /// Show a success message.
  void showSuccess({required String msg}) {
    Flushbar(
      title: 'Success',
      message: msg,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    ).show(this);
  }

  /// Show an error message.
  void showError({required String msg}) {
    Flushbar(
      title: 'Error',
      message: msg,
      backgroundColor: AppColors.red,
      duration: const Duration(seconds: 3),
    ).show(this);
  }
}
