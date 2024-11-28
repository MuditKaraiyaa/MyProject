import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/constants/globals.dart';
import '../../fe_task_list/data/fe_task_list_repositories.dart';

part 'reconfirm_task_event.dart';
part 'reconfirm_task_state.dart';

class ReconfirmTaskBloc extends Bloc<ReconfirmTaskEvent, ReconfirmTaskState> {
  final FieldEngineerTaskListRepository repository;
  ReconfirmTaskBloc(
    this.repository,
  ) : super(ReconfirmTaskInitial()) {
    on<AvailableEvent>(_availableHandler);
  }

  FutureOr<void> _availableHandler(AvailableEvent event, Emitter<ReconfirmTaskState> emit) async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none) {
        emit(ReconfirmTaskLoading());
        final response = await repository.updateTask(
          id: event.sysId,
          data: event.data,
        );
        if (response.result != null) {
          getJson(response);
          emit(ReconfirmTaskSuccess(event.isDecline));
        } else {
          emit(ReconfirmTaskError("Unable to process the request"));
        }
      } else {
        Fluttertoast.showToast(msg: "Please connect to internet");
        emit(ReconfirmTaskError("Unable to process the request"));
      }
    } catch (e) {
      emit(ReconfirmTaskError("Unable to process the request"));
    }
  }
}
