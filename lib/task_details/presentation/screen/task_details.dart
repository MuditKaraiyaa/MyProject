import 'package:flutter/material.dart';
import 'package:xbridge/task_details/presentation/widgets/task_details_state.dart';
import 'package:xbridge/unassigned_visits/data/model/unassigned_task_entity.dart';

// StatefulWidget for displaying task details
class TaskDetails extends StatefulWidget {
  const TaskDetails({
    super.key,
    required this.id,
    required this.selectedButtonIndex,
    required this.model,
    this.showScheduleBtn = false,
  });

  // Unique identifier for the task
  final String id;

  // Indicates whether to show the schedule button
  final bool showScheduleBtn;

  // Index of the selected button
  final int selectedButtonIndex;

  // Model containing task details
  final UnassignedTaskResult? model;

  @override
  State<TaskDetails> createState() => TaskDetailsState();
}
