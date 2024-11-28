part of 'video_call_bloc.dart';

abstract class VideoCallEvent extends Equatable {
  const VideoCallEvent();
}

class CreateMeetingVideoCallEvent extends VideoCallEvent {
  final String? sysID;
  final String? userRole;
  final String? name;

  const CreateMeetingVideoCallEvent({
    this.sysID,
    this.userRole,
    this.name,
  });

  @override
  List<Object?> get props => [sysID, userRole];
}

class AddParticipantVideoCallEvent extends VideoCallEvent {
  final bool isHost;
  final String meetingID;
  final String? sysID;
  final String? userRole;
  final String? name;

  const AddParticipantVideoCallEvent({
    required this.meetingID,
    this.isHost = false,
    this.sysID,
    this.userRole,
    this.name,
  });

  @override
  List<Object?> get props => [meetingID, isHost, sysID, userRole];
}
