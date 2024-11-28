part of 'field_engineer_bloc.dart';

abstract class FieldEngineerEvent extends Equatable {}

class LoadFieldEngineerEvent extends FieldEngineerEvent{
  final String id;
  LoadFieldEngineerEvent({required this.id});
  @override
  List<Object?> get props => [];
}
