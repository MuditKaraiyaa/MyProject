part of 'diagnostic_bloc.dart';

abstract class DiagnosticState extends Equatable {}

class DiagnosticInitialState extends DiagnosticState {
  @override
  List<Object> get props => [];
}

class DiagnosticLoadingState extends DiagnosticState {
  @override
  List<Object> get props => [];
}

class DiagnosticUploadedState extends DiagnosticState {
  final DiagnosticResult? response;

  DiagnosticUploadedState({required this.response});

  @override
  List<Object?> get props => [response];
}

class DiagnosticErrorState extends DiagnosticState {
  final String message;

  DiagnosticErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
