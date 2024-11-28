import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';
import 'package:xbridge/work_note/controller/work_note_event.dart';
import 'package:xbridge/work_note/controller/work_note_state.dart';
import 'package:xbridge/work_note/data/work_note_repositories.dart';

// BLoC class for handling work note-related events and states
class WorkNotesBlock extends Bloc<WorkNotesEvent, WorkNoteState> {
  final WorkNoteRepository repository;

  // Constructor to initialize the repository and set the initial state
  WorkNotesBlock({required this.repository}) : super(WorkNoteLoadingState()) {
    // Register event handlers
    on<WorkNoteUpdateEvent>(_updateTask);
    on<UploadImageEvent>(_uploadCSRPdf);
  }

  // Handler for WorkNoteUpdateEvent
  Future<void> _updateTask(
    WorkNoteUpdateEvent event,
    Emitter<WorkNoteState> emit,
  ) async {
    // Emit loading state
    emit(WorkNoteLoadingState());
    try {
      // Call repository to update the task
      TaskDetailEntity data = await repository.updateTask(
        id: event.id,
        data: event.data,
      );
      if (data.result != null) {
        if (kDebugMode) {
          print("=>>>>>>>>>>>>>${data.result}");
        }
        // Emit loaded state with response data
        emit(WorkNoteLoadedState(response: data));
      }
    } catch (e) {
      // Emit error state with error message
      emit(WorkNoteErrorState(message: e.toString()));
    }
  }

  // Handler for UploadImageEvent
  Future<void> _uploadCSRPdf(
    UploadImageEvent event,
    Emitter<WorkNoteState> emit,
  ) async {
    // Emit loading state
    emit(WorkNoteLoadingState());
    try {
      // Call repository to upload the work note image
      var data = await repository.uploadWorknoteImage(
        taskId: event.taskId,
        image: event.image,
        imageName: event.imageName,
      );
      // Emit loaded state with response data
      emit(WorkNoteLoadedState(response: data.result));
    } catch (e) {
      // Emit error state with error message
      emit(WorkNoteErrorState(message: e.toString()));
    }
  }
}
