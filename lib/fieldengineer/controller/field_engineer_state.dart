part of 'field_engineer_bloc.dart';

abstract class FieldEngineerState extends Equatable {
  const FieldEngineerState();
}

class FieldEngineerLoadingState extends FieldEngineerState {
  @override
  List<Object> get props => [];
}

class FieldEngineerLoadedState extends FieldEngineerState {
  final List<FieldEngineerDetailResult> response;

  const FieldEngineerLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

class FieldEngineerErrorState extends FieldEngineerState {
  final String message;

  const FieldEngineerErrorState({required this.message});

  @override
  List<Object> get props => [message];
}