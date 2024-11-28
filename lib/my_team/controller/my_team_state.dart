import 'package:equatable/equatable.dart';
import '../data/model/my_team_entity.dart';

abstract class MyTeamState extends Equatable {}

class MyTeamLoadingState extends MyTeamState {
  @override
  List<Object> get props => [];
}

class MyTeamLoadedState extends MyTeamState {
  final MyTeamEntity response;

  MyTeamLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

class MyTeamErrorState extends MyTeamState {
  final String message;

  MyTeamErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
