import 'package:flutter/material.dart';
import 'package:xbridge/common/constants/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppColors.loaderColor),
    );
  }
}
