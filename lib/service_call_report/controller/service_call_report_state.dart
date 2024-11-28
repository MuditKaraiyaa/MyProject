import 'package:equatable/equatable.dart';
import 'package:xbridge/service_call_report/data/model/csr_response_entity.dart';

abstract class ServiceCallReportState extends Equatable {}

class ServiceCallReportInitialState extends ServiceCallReportState {
  @override
  List<Object> get props => [];
}

class ServiceCallReportLoadingState extends ServiceCallReportState {
  @override
  List<Object> get props => [];
}

class ServiceCallReportUploadedState extends ServiceCallReportState {
  final CsrResponseResult? response;

  ServiceCallReportUploadedState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ServiceCallReportErrorState extends ServiceCallReportState {
  final String message;

  ServiceCallReportErrorState({required this.message});

  @override
  List<Object> get props => [message];
}