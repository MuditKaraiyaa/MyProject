import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/dashboard/controller/dashboard_event.dart';
import 'package:xbridge/dashboard/controller/dashboard_state.dart';
import 'package:xbridge/dashboard/data/repositories/dashboard.repositories.dart';

class DashboardBlock extends Bloc<DashboardEvent, DashboardState> {
  DashboardRepository repository;

  DashboardBlock({required this.repository}) : super(DashboardLoadingState()) {
    on<DashboardEvent>((event, emit) async {
      if (event is DashboardFetchDataEvent) {
        if (!event.skipLoading) {
          emit(DashboardLoadingState());
        }

        try {
          final result = await repository.getDashboardData();
          emit(DashboardLoadedState(response: result));
        } catch (e) {
          emit(DashboardErrorState(message: e.toString()));
        }
      }
    });
  }
}
