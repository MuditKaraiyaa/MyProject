// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../data/models/case_detail_entity.dart';

// Abstract class representing events related to Task Details
@immutable
abstract class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();
}

// Event to fetch data for a task
class TaskDetailsFetchDataEvent extends TaskDetailsEvent {
  final String id;

  const TaskDetailsFetchDataEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [];
}

// Event to load engineer list for a task
class TaskDetailsEngineerListEvent extends TaskDetailsEvent {
  final CaseDetailEntity result;

  const TaskDetailsEngineerListEvent({required this.result});

  @override
  List<Object?> get props => [result];
}

// Event to update task data
class TaskDetailsUpdateDataEvent extends TaskDetailsEvent {
  final String id;
  final Map<String, dynamic> data;
  final String? toastMessage;
  final bool isBack;
  final int currentTabStatus;
  final bool callUpdateTimeAPi;
  final String? taskNumber;
  final String selectedDate;

  const TaskDetailsUpdateDataEvent({
    required this.id,
    required this.data,
    required this.currentTabStatus,
    required this.selectedDate,
    this.toastMessage,
    this.isBack = false,
    this.callUpdateTimeAPi = false,
    this.taskNumber,
  });

  @override
  List<Object?> get props =>
      [id, data, currentTabStatus, toastMessage, isBack, callUpdateTimeAPi, taskNumber];
}

// Event to update task timing data
class TaskDetailsUpdateDataEventNew extends TaskDetailsEvent {
  final String id;
  final String? taskId;
  final Map<String, dynamic> data;
  final String? toastMessage;
  final bool? isBack;
  final int currentTabStatus;

  const TaskDetailsUpdateDataEventNew({
    required this.id,
    required this.data,
    required this.currentTabStatus,
    this.toastMessage,
    this.taskId,
    this.isBack,
  });

  @override
  List<Object?> get props => [id, data, currentTabStatus, toastMessage, isBack];
}

// Event to handle navigating back from engineer list
class TaskDetailsEngineerBackEvent extends TaskDetailsEvent {
  const TaskDetailsEngineerBackEvent();

  @override
  List<Object?> get props => [];
}
