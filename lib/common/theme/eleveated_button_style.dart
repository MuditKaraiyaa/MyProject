import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButtonStyle {
  static ButtonStyle primaryButtonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    double? borderWidth,
    double? borderRadius,
    Color? borderColor,
    Size? minimumSize,
    Size? maximumSize,
    OutlinedBorder? shape,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      minimumSize: minimumSize ?? Size(120.w, 35.h),
      maximumSize: maximumSize ?? Size(120.w, 35.h),
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    );
  }
}
