import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInInitEvent extends SignInEvent {}

class SignInVerificationEvent extends SignInEvent {
  final String email;
  final String password;

  const SignInVerificationEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class GetAccessTokenEvent extends SignInEvent {}

class LogoutEvent extends SignInEvent {
  final String sysId;

  const LogoutEvent(this.sysId);

  @override
  List<Object?> get props => [sysId];
}
