import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_call_report/data/model/csr_response_entity.dart';
import '../../data/model/diagnostic_entity.dart';
import '../../data/repositories/diagnostic_repository.dart';

part 'diagnostic_event.dart';

part 'diagnostic_state.dart';

class DiagnosticBloc extends Bloc<DiagnosticEvent, DiagnosticState> {
  DiagnosticRepository repository;

  DiagnosticBloc({required this.repository}) : super(DiagnosticInitialState()) {
    on<UploadDiagnosticEvent>(_uploadTxt);
  }

  Future<void> _uploadTxt(
      UploadDiagnosticEvent event,
      Emitter<DiagnosticState> emit,
      ) async {
    emit(DiagnosticLoadingState());
    try {
      DiagnosticEntity data = await repository.uploadTxt(
        file: event.file,
      );
      emit(
        DiagnosticUploadedState(response: data.result),
      );
    } catch (e) {
      emit(
        DiagnosticErrorState(message: e.toString()),
      );
    }
  }
}
