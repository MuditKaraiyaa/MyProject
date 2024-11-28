import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/my_team/controller/my_team_event.dart';
import 'package:xbridge/my_team/controller/my_team_state.dart';
import 'package:xbridge/my_team/data/my_team_repositories.dart';

class MyTeamBlock extends Bloc<MyTeamEvent, MyTeamState> {
  MyTeamRepository repository;

  MyTeamBlock({required this.repository}) : super(MyTeamLoadingState()) {
    on<MyTeamEvent>((event, emit) async {
      if (event is MyTeamFetchDataEvent) {
        emit(MyTeamLoadingState());
        try {
          final result = await repository.getMyTeamList();

          // if ((result.errorResponse?.error.message ?? "").isNotEmpty) {
          //   emit(TaskDetailsErrorState(
          //       message: result.errorResponse?.error.message ?? ""));
          // }

          // else {
          emit(MyTeamLoadedState(response: result));
          // }
        } catch (e) {
          emit(MyTeamErrorState(message: e.toString()));
        }
      }
    });
  }
}
