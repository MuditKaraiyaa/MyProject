import 'package:equatable/equatable.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';

// Abstract class representing the base state for work notes, extending Equatable for value comparison
abstract class WorkNoteState extends Equatable {}

// State representing the loading state of a work note operation
class WorkNoteLoadingState extends WorkNoteState {
  @override
  List<Object> get props => [];
}

// State representing the successful loading of a work note, holding a TaskDetailEntity response
class WorkNoteLoadedState extends WorkNoteState {
  final TaskDetailEntity response;

  // Constructor to initialize the response property
  WorkNoteLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

// State representing an error in a work note operation, holding an error message
class WorkNoteErrorState extends WorkNoteState {
  final String message;

  // Constructor to initialize the message property
  WorkNoteErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
