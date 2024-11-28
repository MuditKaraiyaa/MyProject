import 'package:flutter/material.dart';

import '../../../unassigned_visits/data/model/unassigned_task_entity.dart';
import '../widgets/service_call_state.dart';

class ServiceCall extends StatefulWidget {
  // final CaseDetailEntity result;

  const ServiceCall({
    Key? key,
    required this.model,
    required this.contractID,
    required this.street,
    required this.city,
    required this.country,
    required this.account,
    required this.scheduledDate,
    required this.taskNumber,
    required this.workCompleted,
    required this.departureTime,

    // required this.street,
    // required this.result,
  }) : super(key: key);

  final UnassignedTaskResult model;
  final String contractID;
  final String street;
  final String city;
  final String country;
  final String account;
  final String scheduledDate;
  final String taskNumber;
  final String workCompleted;
  final String departureTime;
  // final CaseDetailEntity result;

  @override
  State<ServiceCall> createState() => ServiceCallState();
}
