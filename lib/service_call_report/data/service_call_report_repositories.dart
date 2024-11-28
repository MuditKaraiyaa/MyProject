import 'dart:convert';

import 'package:xbridge/service_call_report/data/model/csr_response_entity.dart';
import 'package:xbridge/task_details/data/models/case_detail_entity.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';

import '../../common/constants/api_constant.dart';
import '../../common/network/api_provider.dart';

abstract class ServiceCallReportRepository {
  Future<CsrResponseEntity> uploadCSRPdf(
      {required String taskId, required String pdf, required String pdfName,});

  Future<TaskDetailEntity> updateTask(
      {required String id, required Map<String, dynamic> data,});

  Future<CaseDetailEntity> caseDetail({required String id});
}

class ServiceCallReportImpl implements ServiceCallReportRepository {
  final APIProvider provider;

  ServiceCallReportImpl({required this.provider});

  @override
  Future<CsrResponseEntity> uploadCSRPdf(
      {required String taskId, required String pdf, required String pdfName,}) async {
    Map<dynamic, dynamic> request = {
      "agent": "AttachmentCreator",
      "topic": "AttachmentCreator",
      "name": pdfName,
      "source": "sn_customerservice_task:$taskId",
      'payload': pdf,
    };

    final response = await provider.uploadPDF(
      APIConstant.csrAttachment,
      data: jsonEncode(request),
    );
    return CsrResponseEntity.fromJson(response);
  }

  @override
  Future<TaskDetailEntity> updateTask(
      {required String id, required Map<String, dynamic> data,}) async {
    final response = await provider.putMethod(
      '${APIConstant.updateTaskAPI}$id',
      data: jsonEncode(data),
    );
    return TaskDetailEntity.fromJson(response);
  }

  @override
  Future<CaseDetailEntity> caseDetail({required String id}) async {
    final response =
        await provider.getMethod('${APIConstant.caseDetail}$id');

    return CaseDetailEntity.fromJson(response);
  }
}
