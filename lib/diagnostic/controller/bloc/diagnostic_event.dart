part of 'diagnostic_bloc.dart';

abstract class DiagnosticEvent extends Equatable {}

class UploadDiagnosticEvent extends DiagnosticEvent {
  final File file;

  UploadDiagnosticEvent({
    required this.file,
  });

  @override
  List<Object?> get props => [file];
}
