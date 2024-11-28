part of 'reconfirm_task_bloc.dart';

@immutable
sealed class ReconfirmTaskState {}

final class ReconfirmTaskInitial extends ReconfirmTaskState {}

final class ReconfirmTaskLoading extends ReconfirmTaskState {}

final class ReconfirmTaskError extends ReconfirmTaskState {
  final String error;

  ReconfirmTaskError(this.error);
}

final class ReconfirmTaskSuccess extends ReconfirmTaskState {
  final bool isDecline;

  ReconfirmTaskSuccess(this.isDecline);
}
