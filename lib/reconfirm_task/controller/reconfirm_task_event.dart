// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reconfirm_task_bloc.dart';

@immutable
sealed class ReconfirmTaskEvent {}

class AvailableEvent extends ReconfirmTaskEvent {
  final String sysId;
  final Map<String, dynamic> data;
  final bool isDecline;
  AvailableEvent({
    required this.sysId,
    required this.data,
    required this.isDecline,
  });
}
