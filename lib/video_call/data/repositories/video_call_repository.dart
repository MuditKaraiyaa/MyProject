import 'dart:convert';

import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/video_call/data/models/dyte_add_participant_entity.dart';
import 'package:xbridge/video_call/data/models/dyte_create_meeting_entity.dart';

import '../../../common/constants/globals.dart';
import '../../../task_details/data/models/task_detail_entity.dart';

abstract class VideoCallRepository {
  Future<DyteCreateMeetingEntity> createMeeting();

  Future<DyteAddParticipantEntity> addParticipant({
    required String meetingID,
    bool isHost = false,
    String? name,
  });

  Future<TaskDetailEntity> updateTask({
    required String id,
    required Map<String, dynamic> data,
  });
}

class VideoCallRepositoryImpl extends VideoCallRepository {
  final APIProvider provider;

  VideoCallRepositoryImpl({required this.provider});

  @override
  Future<DyteCreateMeetingEntity> createMeeting() async {
    Map<dynamic, dynamic> request = {
      "title": "Video Chat",
      "preferred_region": "ap-south-1",
      "record_on_start": true,
      "live_stream_on_start": false,
    };

    final response = await provider.dytePostMethod(
      APIConstant.dyteCreateMeeting,
      data: jsonEncode(request),
    );
    return DyteCreateMeetingEntity.fromJson(response);
  }

  @override
  Future<DyteAddParticipantEntity> addParticipant({
    required String meetingID,
    bool isHost = false,
    String? name,
  }) async {
    Map<String, dynamic> request = {
      "name": name ?? "$firstName $lastName",
      "custom_participant_id": '${DateTime.now().millisecondsSinceEpoch}',
      "preset_name": isHost ? "group_call_host" : 'group_call_participant',
    };
    getJson(request);
    final response = await provider.dytePostMethod(
      APIConstant.dyteAddParticipant.replaceAll('#', meetingID),
      data: jsonEncode(request),
    );
    return DyteAddParticipantEntity.fromJson(response);
  }

  @override
  Future<TaskDetailEntity> updateTask({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final response = await provider.putMethod(
      '${APIConstant.updateTaskAPI}$id',
      data: jsonEncode(data),
    );
    return TaskDetailEntity.fromJson(response);
  }
}
