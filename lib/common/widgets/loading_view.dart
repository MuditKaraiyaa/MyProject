import 'package:flutter/material.dart';
import 'package:xbridge/common/widgets/loader.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: const Loader(),
    );
  }
}
