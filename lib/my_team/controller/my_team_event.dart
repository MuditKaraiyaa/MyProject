import 'package:equatable/equatable.dart';

abstract class MyTeamEvent extends Equatable {
  const MyTeamEvent();
}

class MyTeamFetchDataEvent extends MyTeamEvent {
  const MyTeamFetchDataEvent();

  @override
  List<Object?> get props => [];
}
