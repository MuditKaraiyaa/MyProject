import 'package:equatable/equatable.dart';

abstract class LogListState extends Equatable {}

class LogListLoadingState extends LogListState {
  @override
  List<Object> get props => [];
}
