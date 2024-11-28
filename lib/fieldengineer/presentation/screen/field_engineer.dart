import 'package:flutter/material.dart';

import '../widget/field_engineer_state.dart';

class FieldEngineer extends StatefulWidget {
  const FieldEngineer({
    super.key,
    required this.userID,
    this.selectedButtonIndex = 1,
  });
  final String userID;
  final int selectedButtonIndex;

  @override
  State<FieldEngineer> createState() => FieldEngineerPageState();
}
