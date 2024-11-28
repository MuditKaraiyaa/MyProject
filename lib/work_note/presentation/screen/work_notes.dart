import 'package:flutter/material.dart';
import 'package:xbridge/work_note/presentation/widgtes/work_notes_state_ui.dart';

import '../../../unassigned_visits/data/model/unassigned_task_entity.dart';

// FEWorkNotes is a StatefulWidget that takes an UnassignedTaskResult model as a parameter
class FEWorkNotes extends StatefulWidget {
  const FEWorkNotes({super.key, required this.model});

  // Model representing the unassigned task
  final UnassignedTaskResult model;

  @override
  State<FEWorkNotes> createState() => FEWorkNotesState();
}
