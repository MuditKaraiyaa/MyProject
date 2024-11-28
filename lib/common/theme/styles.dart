import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbridge/common/constants/app_colors.dart';

/// Abstract class containing text styles used throughout the app.

abstract class Styles {
  static String fontFamily() {
    return "Montserrat";
  }

  static TextStyle textStyleGrey14dpRegular = TextStyle(
    color: AppColors.grey,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyleWhite14dpBold = TextStyle(
    color: AppColors.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyleGrey14dpBold = TextStyle(
    color: AppColors.grey,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyleDarkBlack60dpBold = TextStyle(
    color: AppColors.black,
    fontSize: 60.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlack15dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlack18dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkWhite20dpRegular = TextStyle(
    color: AppColors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack18dpBold = TextStyle(
    color: AppColors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlack13dpBold = TextStyle(
    color: AppColors.black,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlack8dpBold = TextStyle(
    color: AppColors.black,
    fontSize: 8.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkWhit20dpRegular = TextStyle(
    color: AppColors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkWhite18dpRegular = TextStyle(
    color: AppColors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkWhite18dpBold = TextStyle(
    color: AppColors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack40dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack14dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack14dpBold = TextStyle(
    color: AppColors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyleDark12dpBold = TextStyle(
    color: AppColors.dark,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack16dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack20dpBold = TextStyle(
    color: AppColors.black,
    fontSize: 2.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack30dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 30.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyleWhite25dpBold = TextStyle(
    color: AppColors.white,
    fontSize: 25.sp,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyleTextFieldPlaceHolder11dpRegular = TextStyle(
    color: AppColors.placeholderColor,
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyleGrey21dpRegular = TextStyle(
    color: AppColors.lightGrey,
    fontSize: 21.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  //TextStyle(
  //                     fontSize: 20.0,
  //                     color: Colors.grey.shade300),

  static TextStyle textStyledarkRed22dpRegular = TextStyle(
    color: AppColors.red,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkRed18dpRegular = TextStyle(
    color: AppColors.red,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack12dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlack13dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlack10dpRegular = TextStyle(
    color: AppColors.textColorBlackForNonSelected,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyleWhiteForLogIn = TextStyle(
    color: AppColors.textColorWhiteForSelected,
    fontSize: 19.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkWhite10dpRegular = TextStyle(
    color: AppColors.textColorWhiteForSelected,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkWhite13dpRegular = TextStyle(
    color: AppColors.textColorWhiteForSelected,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkWhite13dpBold = TextStyle(
    color: AppColors.textColorWhiteForSelected,
    fontSize: 13.sp,
    fontWeight: FontWeight.w800,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlackDescription12dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyledarkBlackDescription11dpRegular = TextStyle(
    color: AppColors.black,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
  static TextStyle textStyleLightPriority12dpBold = TextStyle(
    color: AppColors.white,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlack12dpBold = TextStyle(
    color: AppColors.textColorBlackForNonSelected,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );

  static TextStyle textStyledarkBlack11dpBold = TextStyle(
    color: AppColors.textColorBlackForNonSelected,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    fontFamily: fontFamily(),
  );
}
