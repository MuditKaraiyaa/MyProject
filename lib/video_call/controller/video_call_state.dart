part of 'video_call_bloc.dart';

class VideoCallState extends Equatable {
  final DyteAddParticipantData? participant;
  final DyteCreateMeetingData? meeting;
  final String? message;
  final String? error;
  final bool isLoading;

  const VideoCallState({
    this.participant,
    this.meeting,
    this.message,
    this.error,
    this.isLoading = false,
  });

  VideoCallState copyWith({
    DyteAddParticipantData? participant,
    DyteCreateMeetingData? meeting,
    String? message,
    String? error,
    bool? isLoading,
  }) {
    return VideoCallState(
      participant: participant ?? this.participant,
      meeting: meeting ?? this.meeting,
      message: message ?? this.message,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [participant, meeting, message, error, isLoading];
}

class VideoCallInitialState extends VideoCallState {
  @override
  List<Object> get props => [];
}
