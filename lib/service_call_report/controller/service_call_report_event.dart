import 'package:equatable/equatable.dart';

abstract class ServiceCallReportEvent extends Equatable {}

class UploadServiceCallReportEvent extends ServiceCallReportEvent {
  final String taskId;
  final String pdf;
  final String pdfName;

  UploadServiceCallReportEvent({
    required this.taskId,
    required this.pdf,
    required this.pdfName,
  });

  @override
  List<Object?> get props => [taskId, pdf, pdfName];
}

class UploadServiceCallReportUpdateEvent extends ServiceCallReportEvent {
  final String id;
  final Map<String, dynamic> data;
  final String pdf;
  final String pdfName;

  UploadServiceCallReportUpdateEvent({
    required this.id,
    required this.data,
    required this.pdf,
    required this.pdfName,
  });

  @override
  List<Object?> get props => [id, data, pdf, pdfName];
}
