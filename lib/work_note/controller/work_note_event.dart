import 'package:equatable/equatable.dart';

// Abstract class representing the base event for work notes, extending Equatable for value comparison
abstract class WorkNotesEvent extends Equatable {
  const WorkNotesEvent();
}

// Event representing an update to a work note with specified id and data
class WorkNoteUpdateEvent extends WorkNotesEvent {
  final String id; // ID of the work note to be updated
  final Map<String, dynamic> data; // Data to update the work note with

  // Constructor to initialize id and data properties
  const WorkNoteUpdateEvent({
    required this.id,
    required this.data,
  });

  @override
  List<Object?> get props => [
        id,
        data,
      ];
}

// Event representing the uploading of an image for a specific task
class UploadImageEvent extends WorkNotesEvent {
  final String taskId; // ID of the task to associate the image with
  final String image; // Base64 encoded image data
  final String imageName; // Name of the image file

  // Constructor to initialize taskId, image, and imageName properties
  const UploadImageEvent({
    required this.taskId,
    required this.image,
    required this.imageName,
  });

  @override
  List<Object?> get props => [taskId, image, imageName];
}
