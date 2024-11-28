import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/utils/util.dart';

import '../../main.dart';
import '../data/field_engineer_repositories.dart';
import '../data/model/field_engineer_detail_entity.dart';

part 'field_engineer_event.dart';
part 'field_engineer_state.dart';

class FieldEngineerBloc extends Bloc<FieldEngineerEvent, FieldEngineerState> {
  FieldEngineerRepository repository;

  FieldEngineerBloc({required this.repository}) : super(FieldEngineerLoadingState()) {
    on<LoadFieldEngineerEvent>(_loadDetail);
  }

  Future<void> _loadDetail(
    LoadFieldEngineerEvent event,
    Emitter<FieldEngineerState> emit,
  ) async {
    try {
      print("event.id: ${event.id}");
      FieldEngineerDetailEntity data = await repository.getEngineerDetail(
        id: event.id,
      );
      if (data.result == null) {
        logger.i(getJson(data.result));
        const FieldEngineerErrorState(message: "no users found");
      } else {
        if (data.result!.isEmpty) {
          const FieldEngineerErrorState(message: "no users found");
        } else {
          emit(
            FieldEngineerLoadedState(response: data.result ?? []),
          );
        }
      }
    } catch (e) {
      emit(
        FieldEngineerErrorState(message: e.toString()),
      );
    }
  }
}
