import 'package:dyte_uikit/dyte_uikit.dart';
import 'package:flutter/material.dart';

class DyteMeetingPage extends StatefulWidget {
  const DyteMeetingPage({
    super.key,
    required this.uiKitBuilder,
  });

  final DyteUiKit uiKitBuilder;

  @override
  State<DyteMeetingPage> createState() => _DyteMeetingPageState();
}

class _DyteMeetingPageState extends State<DyteMeetingPage> {
  @override
  Widget build(BuildContext context) {
    return widget.uiKitBuilder;
  }
}
