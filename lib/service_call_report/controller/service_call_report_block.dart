import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/service_call_report/controller/service_call_report_event.dart';
import 'package:xbridge/service_call_report/controller/service_call_report_state.dart';
import 'package:xbridge/service_call_report/data/model/csr_response_entity.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';

import '../data/service_call_report_repositories.dart';

class ServiceCallReportBlock extends Bloc<ServiceCallReportEvent, ServiceCallReportState> {
  ServiceCallReportRepository repository;

  ServiceCallReportBlock({required this.repository}) : super(ServiceCallReportInitialState()) {
    on<UploadServiceCallReportEvent>(_uploadCSRPdf);
    on<UploadServiceCallReportUpdateEvent>(_updateTask);
  }

  Future<void> _uploadCSRPdf(
    UploadServiceCallReportEvent event,
    Emitter<ServiceCallReportState> emit,
  ) async {
    emit(ServiceCallReportLoadingState());
    try {
      CsrResponseEntity data = await repository.uploadCSRPdf(
        taskId: event.taskId,
        pdf: event.pdf,
        pdfName: event.pdfName,
      );
      emit(
        ServiceCallReportUploadedState(response: data.result),
      );
    } catch (e) {
      emit(
        ServiceCallReportErrorState(message: e.toString()),
      );
    }
  }

  Future<void> _updateTask(
    UploadServiceCallReportUpdateEvent event,
    Emitter<ServiceCallReportState> emit,
  ) async {
    emit(ServiceCallReportLoadingState());
    try {
      TaskDetailEntity data = await repository.updateTask(
        id: event.id,
        data: event.data,
      );
      if (data.result != null) {
        add(
          UploadServiceCallReportEvent(
            pdf: event.pdf,
            taskId: event.id,
            pdfName: event.pdfName,
          ),
        );
      }
    } catch (e) {
      emit(
        ServiceCallReportErrorState(message: e.toString()),
      );
    }
  }
}
