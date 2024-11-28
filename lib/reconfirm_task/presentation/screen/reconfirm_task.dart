// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../widget/reconfirm_task_state.dart';

class ReConfirmTask extends StatefulWidget {
  const ReConfirmTask({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Map<String, dynamic> data;
  @override
  State<ReConfirmTask> createState() => ReConfirmTaskState();
}
