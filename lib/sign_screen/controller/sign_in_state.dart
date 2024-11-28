import 'package:equatable/equatable.dart';

import '../data/models/sign_in_response_model.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInLoadedState extends SignInState {
  final SignInResponse response;

  const SignInLoadedState({required this.response});

  @override
  List<Object?> get props => [response];
}

class SignInErrorState extends SignInState {
  final String message;

  const SignInErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AccessToeknLoadedState extends SignInState {
  final dynamic response;

  const AccessToeknLoadedState({required this.response});

  @override
  List<Object?> get props => [response];
}

class AccessToeknErrorState extends SignInState {
  final String message;

  const AccessToeknErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
