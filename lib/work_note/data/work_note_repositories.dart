import 'dart:convert';

import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';

import '../../main.dart';

// Abstract class defining the contract for the WorkNote repository
abstract class WorkNoteRepository {
  // Method to update a task with the given id and data
  Future<TaskDetailEntity> updateTask({
    required String id,
    required Map<String, dynamic> data,
  });

  // Method to upload a work note image with the given taskId, image, and imageName
  Future uploadWorknoteImage({
    required String taskId,
    required String image,
    required String imageName,
  });
}

// Implementation of the WorkNoteRepository interface
class WorkNoteImpl implements WorkNoteRepository {
  final APIProvider provider; // Dependency on an API provider for network requests

  // Constructor to initialize the API provider
  WorkNoteImpl({required this.provider});

  @override
  Future<TaskDetailEntity> updateTask({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    // Send a PUT request to update the task with the given id and data
    final response = await provider.putMethod(
      '${APIConstant.updateTaskAPI}$id',
      data: jsonEncode(data),
    );
    // Parse the response into a TaskDetailEntity object and return it
    return TaskDetailEntity.fromJson(response);
  }

  @override
  Future uploadWorknoteImage({
    required String taskId,
    required String image,
    required String imageName,
  }) async {
    // Create a request map with the necessary fields for uploading an image
    Map<dynamic, dynamic> request = {
      "agent": "AttachmentCreator",
      "topic": "AttachmentCreator",
      "name": imageName,
      "source": "sn_customerservice_task:$taskId",
      'payload': image,
    };

    // Send the request to upload the image and log the response
    final response = await provider.uploadPDF(
      APIConstant.csrAttachment,
      data: jsonEncode(request),
    );
    logger.i(response);
    return response;
  }
}
