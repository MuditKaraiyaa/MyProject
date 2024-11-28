import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';

import '../../common/utils/util.dart';
import '../../main.dart';
import '../../task_details/data/models/task_detail_entity.dart';
import '../data/models/dyte_add_participant_entity.dart';
import '../data/models/dyte_create_meeting_entity.dart';
import '../data/repositories/video_call_repository.dart';

part 'video_call_event.dart';
part 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  VideoCallRepository repository;

  VideoCallBloc({required this.repository}) : super(VideoCallInitialState()) {
    on<CreateMeetingVideoCallEvent>(_createMeeting);
    on<AddParticipantVideoCallEvent>(_addParticipant);
  }

  Future<void> _createMeeting(
    CreateMeetingVideoCallEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // try {
    DyteCreateMeetingEntity result = await repository.createMeeting();
    if (result.success == true) {
      add(
        AddParticipantVideoCallEvent(
          meetingID: result.data?.id ?? '',
          sysID: event.sysID,
          userRole: event.userRole,
          name: event.name,
        ),
      );
      // emit(state.copyWith(
      //   meeting: result.data,
      //   error: null,
      //   isLoading: false,
      // ));
    }
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       error: e.toString(),
    //       isLoading: false,
    //     ),
    //   );
    // }
  }

  Future<void> _addParticipant(
    AddParticipantVideoCallEvent event,
    Emitter<VideoCallState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    // try {
    DyteAddParticipantEntity result = await repository.addParticipant(
      meetingID: event.meetingID,
      isHost: event.isHost,
      name: event.name,
    );
    if (event.isHost && result.data?.token != null) {
      emit(
        state.copyWith(
          participant: result.data,
          error: null,
          message: null,
          isLoading: false,
        ),
      );
    } else {
      String userLink =
          '${Constants.dyteMeetingBaseURL}${event.meetingID}&authToken=${result.data?.token}';
      debugPrint(userLink);
      TaskDetailEntity data = await repository.updateTask(
        id: event.sysID ?? '',
        data: {
          'u_video_call_url': userLink,
          'u_video_call_participants': event.userRole,
        },
      );
      logger.i(
        getJson({
          'u_video_call_url': userLink,
          'u_video_call_participants': event.userRole,
        }),
      );
      logger.i(getJson(data));
      if (data.result != null) {
        add(
          AddParticipantVideoCallEvent(
            meetingID: event.meetingID,
            sysID: event.sysID,
            isHost: true,
          ),
        );
        // emit(state.copyWith(
        //   message: 'Participant added successfully!!',
        //   error: null,
        //   isLoading: false,
        // ));
      }
      debugPrint('Joining link user ==> $userLink');
    }
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       error: e.toString(),
    //       isLoading: false,
    //     ),
    //   );
    // }
  }
}
