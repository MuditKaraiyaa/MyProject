import 'package:equatable/equatable.dart';
import 'package:xbridge/dashboard/data/model/dashboard.model.dart';

abstract class DashboardState extends Equatable {}

class DashboardLoadingState extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoadedState extends DashboardState {
  final DashboardResult response;

  DashboardLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

class DashboardErrorState extends DashboardState {
  final String message;

  DashboardErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
